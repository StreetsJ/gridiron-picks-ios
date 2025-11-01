//
//  ChallengeModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/6/25.
//

import Foundation
import FirebaseFirestore

enum ChallengeStatus: String {
    case voting
    case picking
    case closed
    case completed
}

struct ChallengeModel: Decodable, Identifiable {
    @DocumentID var id: String?
    let player1Id: String
    let player2Id: String
    let gameIds: [String]
    let player1Wins: Int
    let player1Ties: Int
    let player1Losses: Int
    let player2Wins: Int
    let player2Ties: Int
    let player2Losses: Int
    var seasonYear: Int
    var week: Int
    
    // Display names (not stored in Firestore, populated locally)
    var player1DisplayName: String?
    var player2DisplayName: String?
    var title: String = "Title"
    var status: String = "voting"
    
    static let mockChallenges: [ChallengeModel] = [
        ChallengeModel(
            player1Id: "user1",
            player2Id: "user2",
            gameIds: ["0", "1", "2", "3"],
            player1Wins: 10,
            player1Ties: 5,
            player1Losses: 5,
            player2Wins: 10,
            player2Ties: 0,
            player2Losses: 10,
            seasonYear: 2025,
            week: 3,
            title: "Super Bowl LVI",
            status: "voting"
        ),
        ChallengeModel(
            player1Id: "user1",
            player2Id: "user4",
            gameIds: ["8", "9", "10", "11"],
            player1Wins: 45,
            player1Ties: 0,
            player1Losses: 32,
            player2Wins: 50,
            player2Ties: 0,
            player2Losses: 27,
            seasonYear: 2025,
            week: 3,
            title: "Super Bowl LVIII",
            status: "picking"
        ),
        ChallengeModel(
            player1Id: "user1",
            player2Id: "user3",
            gameIds: ["4", "5", "6", "7"],
            player1Wins: 67,
            player1Ties: 1,
            player1Losses: 13,
            player2Wins: 63,
            player2Ties: 0,
            player2Losses: 18,
            seasonYear: 2025,
            week: 3,
            title: "Super Bowl LVII",
            status: "closed"
      ),
    ]
    
    func getStatus() -> ChallengeStatus {
        switch status {
        case "voting":
            return .voting
        case "picking":
            return .picking
        case "closed":
            return ChallengeStatus.closed
        case "completed":
            return ChallengeStatus.completed
        default:
            return .voting
        }
    }
}
