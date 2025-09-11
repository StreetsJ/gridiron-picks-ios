//
//  SportsAppMock.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/1/25.
//

import SwiftUI

struct SportsAppMock: View {
    @State private var selectedTab = "Week 1"
    let tabs = ["Week 0", "Week 1", "Week 2"]
    let games = Game.mockGames
    
    var body: some View {
        ZStack{
            VStack(spacing: 16) {
                Spacer(minLength: 0)
                
                // Rounded container for tabs and content
                VStack(spacing: 0) {
                    // Custom header tabs
                    HStack(spacing: 0) {
                        ForEach(tabs, id: \.self) { tab in
                            Button(action: {
                                selectedTab = tab
                            }) {
                                VStack(spacing: 8) {
                                    Text(tab)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(selectedTab == tab ? .white : Color.white.opacity(0.7))
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)
                    .background(Color.black.opacity(0.3))
                    
                    Divider()
                        .background(Color.white.opacity(0.2))
                    
                    // Games list
                    ScrollView(showsIndicators: false) {
                        LazyVStack(spacing: 1) {
                            ForEach(gamesForSelectedTab(), id: \.id) { game in
                                TeamSelectorView(homeTeam: game.homeTeam.name, awayTeam: game.awayTeam.name)
                                    .padding()
                                Text(game.time)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                    .background(Color.black.opacity(0.2))
                }
                .listContainerBackground()
            }
        }
    }
    
    func gamesForSelectedTab() -> [GameA] {
        switch selectedTab {
        case "Week 0":
            return yesterdayGames
        case "Week 1":
            return todayGames
        case "Week 2":
            return upcomingGames
        default:
            return todayGames
        }
    }
}

struct GameRowView: View {
    let game: GameA
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                // League and time
                HStack {
                    Text(game.league)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fontWeight(.medium)
                    
                    Spacer()
                    
                    Text(game.time)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                // Teams
                HStack(alignment: .center, spacing: 12) {
                    // Away team
                    HStack(spacing: 8) {
                        Image(systemName: "sportscourt.fill")
                            .foregroundColor(.blue)
                            .frame(width: 24, height: 24)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text(game.awayTeam.city)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(game.awayTeam.name)
                                .font(.system(size: 16, weight: .medium))
                        }
                    }
                    
                    if let awayScore = game.awayScore {
                        Text("\(awayScore)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    
                    Spacer()
                    
                    // @ symbol or VS
                    Text("@")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    if let homeScore = game.homeScore {
                        Text("\(homeScore)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.primary)
                    }
                    
                    // Home team
                    HStack(spacing: 8) {
                        VStack(alignment: .trailing, spacing: 2) {
                            Text(game.homeTeam.city)
                                .font(.caption)
                                .foregroundColor(.secondary)
                            Text(game.homeTeam.name)
                                .font(.system(size: 16, weight: .medium))
                        }
                        
                        Image(systemName: "house.fill")
                            .foregroundColor(.orange)
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding(.horizontal, 20)
//        .padding(.vertical, 16)
        .background(Color(.systemBackground))
    }
}

// MARK: - Data Models

struct GameA {
    let id = UUID()
    let league: String
    let awayTeam: Team
    let homeTeam: Team
    let time: String
    let awayScore: Int?
    let homeScore: Int?
}

struct Team {
    let city: String
    let name: String
}

// MARK: - Sample Data

let yesterdayGames = [
    GameA(league: "NBA",
         awayTeam: Team(city: "LA", name: "Lakers"),
         homeTeam: Team(city: "Boston", name: "Celtics"),
         time: "Final",
         awayScore: 108,
         homeScore: 115),
    
    GameA(league: "NFL",
         awayTeam: Team(city: "Dallas", name: "Cowboys"),
         homeTeam: Team(city: "NY", name: "Giants"),
         time: "Final",
         awayScore: 21,
         homeScore: 17),
    
    GameA(league: "MLB",
         awayTeam: Team(city: "NY", name: "Yankees"),
         homeTeam: Team(city: "Houston", name: "Astros"),
         time: "Final",
         awayScore: 7,
         homeScore: 4)
]

let todayGames = [
    GameA(league: "NBA",
         awayTeam: Team(city: "Miami", name: "Heat"),
         homeTeam: Team(city: "Denver", name: "Nuggets"),
         time: "8:00 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NHL",
         awayTeam: Team(city: "Toronto", name: "Maple Leafs"),
         homeTeam: Team(city: "Tampa Bay", name: "Lightning"),
         time: "7:30 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NBA",
         awayTeam: Team(city: "Golden State", name: "Warriors"),
         homeTeam: Team(city: "Phoenix", name: "Suns"),
         time: "10:00 PM",
         awayScore: nil,
         homeScore: nil),
    GameA(league: "NBA",
         awayTeam: Team(city: "Miami", name: "Heat"),
         homeTeam: Team(city: "Denver", name: "Nuggets"),
         time: "8:00 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NHL",
         awayTeam: Team(city: "Toronto", name: "Maple Leafs"),
         homeTeam: Team(city: "Tampa Bay", name: "Lightning"),
         time: "7:30 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NBA",
         awayTeam: Team(city: "Golden State", name: "Warriors"),
         homeTeam: Team(city: "Phoenix", name: "Suns"),
         time: "10:00 PM",
         awayScore: nil,
         homeScore: nil),
    GameA(league: "NBA",
         awayTeam: Team(city: "Miami", name: "Heat"),
         homeTeam: Team(city: "Denver", name: "Nuggets"),
         time: "8:00 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NHL",
         awayTeam: Team(city: "Toronto", name: "Maple Leafs"),
         homeTeam: Team(city: "Tampa Bay", name: "Lightning"),
         time: "7:30 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NBA",
         awayTeam: Team(city: "Golden State", name: "Warriors"),
         homeTeam: Team(city: "Phoenix", name: "Suns"),
         time: "10:00 PM",
         awayScore: nil,
         homeScore: nil),
    GameA(league: "NBA",
         awayTeam: Team(city: "Miami", name: "Heat"),
         homeTeam: Team(city: "Denver", name: "Nuggets"),
         time: "8:00 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NHL",
         awayTeam: Team(city: "Toronto", name: "Maple Leafs"),
         homeTeam: Team(city: "Tampa Bay", name: "Lightning"),
         time: "7:30 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NBA",
         awayTeam: Team(city: "Golden State", name: "Warriors"),
         homeTeam: Team(city: "Phoenix", name: "Suns"),
         time: "10:00 PM",
         awayScore: nil,
         homeScore: nil)
]

let upcomingGames = [
    GameA(league: "NFL",
         awayTeam: Team(city: "Green Bay", name: "Packers"),
         homeTeam: Team(city: "Chicago", name: "Bears"),
         time: "Tomorrow 1:00 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "NBA",
         awayTeam: Team(city: "Milwaukee", name: "Bucks"),
         homeTeam: Team(city: "Atlanta", name: "Hawks"),
         time: "Tomorrow 7:00 PM",
         awayScore: nil,
         homeScore: nil),
    
    GameA(league: "MLB",
         awayTeam: Team(city: "San Francisco", name: "Giants"),
         homeTeam: Team(city: "LA", name: "Dodgers"),
         time: "Tomorrow 10:00 PM",
         awayScore: nil,
         homeScore: nil)
]

// MARK: - Preview

struct SportsAppMock_Previews: PreviewProvider {
    static var previews: some View {
        SportsAppMock()
    }
}
