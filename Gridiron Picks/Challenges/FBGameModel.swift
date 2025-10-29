//
//  FBGameModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/12/25.
//

import Foundation
import FirebaseFirestore

struct FBGameModel: Decodable, Identifiable {
    @DocumentID var id: String?
    
    let awayRank: Int?
    var awayScore: Int?
    let awayTeam: String
    let homeRank: Int?
    var homeScore: Int?
    let homeTeam: String
    var isCompleted: Bool
    let seasonYear: Int
    let spread: Double
    let startDate: Date
    let week: Int
    var winningTeam: String?
    var formattedSpread: String?
    
    static let mockGames: [FBGameModel] = [
        FBGameModel(
            id: "1",
            awayRank: 1,
            awayTeam: "Texas",
            homeRank: 3,
            homeTeam: "Ohio State",
            isCompleted: false,
            seasonYear: 2025,
            spread: 3.5,
            startDate: Date(),
            week: 1
        ),
        FBGameModel(
            id: "2",
            awayRank: nil,
            awayTeam: "Wisconsin",
            homeRank: 14,
            homeTeam: "Alabama",
            isCompleted: false,
            seasonYear: 2025,
            spread: 9.5,
            startDate: Date(),
            week: 1
        ),
        FBGameModel(
            id: "3",
            awayRank: 19,
            awayTeam: "Texas A&M",
            homeRank: 7,
            homeTeam: "Notre Dame",
            isCompleted: false,
            seasonYear: 2025,
            spread: 1.5,
            startDate: Date().addingTimeInterval(3600),
            week: 1
        ),
    ]
}
