//
//  Game.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import Foundation

struct Game: Decodable, Identifiable {
    let id: Int64
    let startDate: Date
    let completed: Bool
    let home: TeamInfo
    let away: TeamInfo
    
    enum CodingKeys: String, CodingKey {
        case id
        case startDate
        case completed
        case homeId
        case homeTeam
        case homeConference
        case homePoints
        case homeLineScores
        case awayId
        case awayTeam
        case awayConference
        case awayPoints
        case awayLineScores
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Parse ISO8601 date
        let dateString = try container.decode(String.self, forKey: .startDate)
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        guard let date = formatter.date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .startDate,
                                                   in: container,
                                                   debugDescription: "Date string does not match format")
        }
        
        self.id = try container.decode(Int64.self, forKey: .id)
        self.startDate = date
        self.completed = try container.decode(Bool.self, forKey: .completed)
        
        // Home team
        self.home = TeamInfo(
            id: try container.decode(Int.self, forKey: .homeId),
            team: try container.decode(String.self, forKey: .homeTeam),
            conference: try container.decode(String.self, forKey: .homeConference),
            points: try? container.decode(Int.self, forKey: .homePoints),
            lineScores: try? container.decode([Int].self, forKey: .homeLineScores)
        )
        
        // Away team
        self.away = TeamInfo(
            id: try container.decode(Int.self, forKey: .awayId),
            team: try container.decode(String.self, forKey: .awayTeam),
            conference: try container.decode(String.self, forKey: .awayConference),
            points: try? container.decode(Int.self, forKey: .awayPoints),
            lineScores: try? container.decode([Int].self, forKey: .awayLineScores)
        )
    }
    
    init(id: Int64, startDate: Date, completed: Bool, home: TeamInfo, away: TeamInfo) {
        self.id = id
        self.startDate = startDate
        self.completed = completed
        self.home = home
        self.away = away
    }
    
    static let mockGames: [Game] = [
        Game(
            id: 0,
            startDate: Date(),
            completed: false,
            home: TeamInfo(id: 0, team: "Texas A&M", conference: "SEC", points: nil, lineScores: nil),
            away: TeamInfo(id: 1, team: "UTSA", conference: "AAC", points: nil, lineScores: nil),
        ),
        Game(
            id: 1,
            startDate: Date().addingTimeInterval(3600),
            completed: false,
            home: TeamInfo(id: 2, team: "Ohio State", conference: "Big Ten", points: nil, lineScores: nil),
            away: TeamInfo(id: 3, team: "Texas", conference: "SEC", points: nil, lineScores: nil),
        ),
        Game(
            id: 2,
            startDate: Date().addingTimeInterval(3600 * 2),
            completed: false,
            home: TeamInfo(id: 4, team: "UNC", conference: "ACC", points: nil, lineScores: nil),
            away: TeamInfo(id: 5, team: "TCU", conference: "Big 12", points: nil, lineScores: nil),
        ),
        Game(
            id: 3,
            startDate: Date().addingTimeInterval(3600 * 3),
            completed: false,
            home: TeamInfo(id: 4, team: "Virginia Tech", conference: "ACC", points: nil, lineScores: nil),
            away: TeamInfo(id: 5, team: "South Carolina", conference: "SEC", points: nil, lineScores: nil),
        ),
        Game(
            id: 4,
            startDate: Date().addingTimeInterval(3600 * 4),
            completed: false,
            home: TeamInfo(id: 4, team: "Notre Dame", conference: "Independens", points: nil, lineScores: nil),
            away: TeamInfo(id: 5, team: "Miami", conference: "ACC", points: nil, lineScores: nil),
        ),
    ]
}

extension Date {
    var shortStyle: String {
        self.formatted(date: .abbreviated, time: .shortened)
    }
}

struct TeamInfo: Decodable, Identifiable {
    let id: Int
    let team: String
    let conference: String
    let points: Int?
    let lineScores: [Int]?
}
