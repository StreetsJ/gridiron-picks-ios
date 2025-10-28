//
//  ChallengeViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/11/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore

//class ChallengeViewModel: ObservableObject {
//    let challengeId: String
//    let challenge: ChallengeModel
//    
//    @Published var games: [Game] = Game.mockGames
//    @Published var isLoading = false
//    @Published var errorMessage: String?
//    
//    let db = Firestore.firestore()
    
//    init(challengeId: String, challenge: ChallengeModel) {
//        self.challengeId = challengeId
//        self.challenge = challenge
//        
//        fetchGames(forChallengeId: self.challengeId)
//    }
//    
//    func fetchGames(forChallengeId challengeId: String) {
//        Task {
//            await fetchGamesAsync(forChallengeId: challengeId)
//        }
//    }
    
//    @MainActor
//    private func fetchGamesAsync(forChallengeId challengeId: String) async {
//        isLoading = true
//        errorMessage = nil
//        
//        do {
//            // 1. Get the Challenge document
//            db.collection("challenges").document(challengeId).getDocument { (challengeDocument, error) in
//                if let error = error {
//                    print("Error getting challenge document: \(error.localizedDescription)")
//                    return
//                }
//
//                guard let challengeData = challengeDocument?.data(), challengeDocument?.exists == true else {
//                    print("Challenge document does not exist.")
//                    return
//                }
//
//                // Extract gameIds from the challenge document
//                guard let gameIds = challengeData["gameIds"] as? [String] else {
//                    print("Challenge document does not contain 'gameIds' array.")
//                    return
//                }
//
//                print("Challenge data: \(challengeData)")
//                print("Games to fetch: \(gameIds)")
//
//                // Proceed to fetch games and picks using the extracted gameIds and challengeId
//                fetchGamesForChallenge(gameIds: gameIds)
//                fetchAllPicksForChallenge(challengeId: challengeId)
//            }
//            
//            challenges = updatedChallenges
//            isLoading = false
//            
//        } catch {
//            print("Error getting challenges: \(error.localizedDescription)")
//            errorMessage = error.localizedDescription
//            isLoading = false
//        }
//    }
//}
