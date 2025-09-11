//
//  ChallengeViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/6/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class ChallengeViewModel: ObservableObject {
    @Published var challenges: [ChallengeModel] = []
    @Published var userDisplayNames: [String: String] = [:]
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var currentUserUID: String? {
        Auth.auth().currentUser?.uid
    }
    
    private var shouldUseMockData: Bool {
        return true
    }
    
    init() {
        if shouldUseMockData {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.challenges = ChallengeModel.mockChallenges
                self.userDisplayNames = ["user1": "You", "user2": "Zach", "user3": "Ari"]
            }
        } else {
            if let currentUserUID = Auth.auth().currentUser?.uid {
                fetchUserChallenges(forUserId: currentUserUID)
            }
        }
    }
    
    func fetchUserChallenges(forUserId userId: String) {
        Task {
            await fetchUserChallengesAsync(forUserId: userId)
        }
    }
    
    @MainActor
    private func fetchUserChallengesAsync(forUserId userId: String) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let db = Firestore.firestore()
            let querySnapshot = try await db.collection("challenges")
                .whereField("participants", arrayContains: userId)
                .getDocuments()
            
            // Decode challenges first
            var decodedChallenges: [ChallengeModel] = []
            
            for document in querySnapshot.documents {
                do {
                    var challenge = try document.data(as: ChallengeModel.self)
                    challenge.id = document.documentID
                    decodedChallenges.append(challenge)
                } catch {
                    print("Error decoding challenge: \(error)")
                }
            }
            
            // Fetch display names concurrently and return updated challenges
            let updatedChallenges = await withTaskGroup(of: ChallengeModel.self) { group in
                for challenge in decodedChallenges {
                    group.addTask {
                        await self.fetchUserDisplayName(forUserId: challenge.player2Id)
                        await self.fetchUserDisplayName(forUserId: challenge.player1Id)
                        
                        return challenge
                    }
                }
                
                var results: [ChallengeModel] = []
                for await updatedChallenge in group {
                    results.append(updatedChallenge)
                }
                return results
            }
            
            challenges = updatedChallenges
            isLoading = false
            
        } catch {
            print("Error getting challenges: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
    
    private func fetchUserDisplayName(forUserId userId: String) async {
        guard !userId.isEmpty else { return }

        // 1. Handle current user: display "You"
        if userId == currentUserUID {
            userDisplayNames[userId] = "You"
            return
        }

        // 2. Check cache: if already fetched, return early
        if userDisplayNames[userId] != nil {
            return
        }

        // 3. Fetch from Firestore if not current user and not in cache
        do {
            let db = Firestore.firestore()
            let documentSnapshot = try await db.collection("users").document(userId).getDocument()
            let appUser = try documentSnapshot.data(as: AppUser.self)
            self.userDisplayNames[userId] = appUser.displayName
        } catch {
            print("Error fetching user display name for \(userId): \(error.localizedDescription)")
            self.userDisplayNames[userId] = "Error loading name" // Indicate an error in the UI
            self.errorMessage = "Failed to fetch user display name: \(error.localizedDescription)"
        }
    }
    
    /// Helper function to retrieve the display name for a user ID,
    /// prioritizing "You" for the current user and showing "Loading..." otherwise.
    func getDisplayName(for userId: String) -> String {
        if userId == currentUserUID {
            return "You"
        }
        return userDisplayNames[userId] ?? "Loading..." // Default until loaded
    }

    
    func refreshChallenges() {
        if let currentUserUID = Auth.auth().currentUser?.uid {
            fetchUserChallenges(forUserId: currentUserUID)
        }
    }
}
