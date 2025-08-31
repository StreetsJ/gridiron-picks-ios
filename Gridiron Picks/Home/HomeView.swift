//
//  HomeView.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var dataManager = CFBDataManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                if dataManager.games.isEmpty {
                    Text("Loading games...")
                        .padding()
                } else {
                    List(dataManager.games) { game in
                        VStack(alignment: .leading) {
                            Text("\(game.awayTeam) @ \(game.homeTeam)")
                                .font(.headline)
                            Text(game.startDate)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Top 25 Games")
            .task {
                // Example: week 4
                await dataManager.fetchTop25Games(week: 4)
            }
        }
    }
}
