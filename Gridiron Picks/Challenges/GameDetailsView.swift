//
//  GameDetailsView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/10/25.
//
import SwiftUI

struct GameDetailsView: View {
    let game: FBGameModel
    
    var body: some View {
        HStack {
            Spacer()
            
            // Away
            VStack {
                TeamTitleView(rank: game.awayRank, name: game.awayTeam)
                Text("Conference")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Time
            VStack {
                Text("@")
                    .font(.title)
                    .foregroundStyle(.secondary)
                Text(String(game.spread))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(game.startDate.shortStyle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Home
            VStack {
                TeamTitleView(rank: game.homeRank, name: game.homeTeam)
                Text("Conference")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
    }
}

#Preview {
//    GameDetailsView(game: Game.mockGames[0])
//        .appGradientBackground()
}
