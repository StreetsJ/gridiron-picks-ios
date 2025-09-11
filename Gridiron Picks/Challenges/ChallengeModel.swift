//
//  ChallengeModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/6/25.
//

import Foundation
import FirebaseFirestore

struct ChallengeModel: Decodable, Identifiable {
    @DocumentID var id: String?
    let player1Id: String
    let player2Id: String
    let gameIds: [String]
    var seasonYear: Int
    var week: Int
    
    // Display names (not stored in Firestore, populated locally)
    var player1DisplayName: String?
    var player2DisplayName: String?
    var title: String = "Title"
    
    static let mockChallenges: [ChallengeModel] = [
        ChallengeModel(player1Id: "user1", player2Id: "user2", gameIds: ["0", "1", "2", "3"], seasonYear: 2025, week: 3, title: "Super Bowl LVI"),
        ChallengeModel(player1Id: "user1", player2Id: "user3", gameIds: ["4", "5", "6", "7"], seasonYear: 2025, week: 3, title: "Super Bowl LVII"),
    ]
}
