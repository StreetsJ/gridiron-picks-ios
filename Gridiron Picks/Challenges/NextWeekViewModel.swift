//
//  NextWeekViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/12/25.
//
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class NextWeekViewModel: ObservableObject {
    let week: Int = 3
    let year: Int = 2025
    
    @Published var games: [FBGameModel] = []
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init() {
        Task {
            await loadData()
        }
    }
    
    @MainActor
    private func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let db = Firestore.firestore()
            let querySnapshot = try await db.collection("games")
                .whereField("week", isEqualTo: self.week)
                .whereField("seasonYear", isEqualTo: self.year)
                .getDocuments()
            
            var decodedGames: [FBGameModel] = []
            
            for document in querySnapshot.documents {
                do {
                    var game = try document.data(as: FBGameModel.self)
                    game.id = document.documentID
                    decodedGames.append(game)
                } catch {
                    print("Error decoding game: \(error)")
                }
            }
            
            // Fetch display names concurrently and return updated challenges
//            let updatedChallenges = await withTaskGroup(of: ChallengeModel.self) { group in
//                for challenge in decodedChallenges {
//                    group.addTask {
//                        await self.fetchUserDisplayName(forUserId: challenge.player2Id)
//                        await self.fetchUserDisplayName(forUserId: challenge.player1Id)
//                        
//                        return challenge
//                    }
//                }
//                
//                var results: [ChallengeModel] = []
//                for await updatedChallenge in group {
//                    results.append(updatedChallenge)
//                }
//                return results
//            }
            
            games = decodedGames
            isLoading = false
        } catch {
            print("Error getting games: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
