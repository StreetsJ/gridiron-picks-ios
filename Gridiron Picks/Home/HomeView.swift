//
//  HomeView.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject var dataManager: CFBDataManager

    init(dataManager: CFBDataManager = CFBDataManager()) {
        _dataManager = StateObject(wrappedValue: dataManager)
    }
    
    var body: some View {
        VStack {
            if dataManager.games.isEmpty {
                Text("Loading games...")
                    .padding()
            } else {
                List(dataManager.games) { game in
                    VStack(alignment: .center) {
                        TeamSelectorView(homeTeam: game.home.team, awayTeam: game.away.team)
                        Text(game.startDate.shortStyle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.vertical, 4)
                }
            }
        }
        .task {
            await dataManager.fetchTop25Games(week: 1)
        }
    }
}

#Preview("Mock Games") {
    let mockManager = CFBDataManager(mockGames: Game.mockGames)
    
    HomeView(dataManager: mockManager)
}
