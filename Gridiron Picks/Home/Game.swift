//
//  Game.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import Foundation

struct Game: Codable, Identifiable {
    let id = UUID()            // local id for SwiftUI
    let homeTeam: String
    let awayTeam: String
    let startDate: String      // raw string from API
    let week: Int
    
    enum CodingKeys: String, CodingKey {
        case homeTeam = "home_team"
        case awayTeam = "away_team"
        case startDate = "start_date"
        case week
    }
}
