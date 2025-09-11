//
//  GameDetailsView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/10/25.
//
import SwiftUI

struct GameDetailsView: View {
    let game: Game
    
    var body: some View {
        HStack {
            Spacer()
            
            // Away
            VStack {
                Text(game.away.team)
                Text(game.away.conference)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text((game.away.lineScores?.first!)!)
            }
            
            Spacer()
            
            // Time
            VStack {
                Text("@")
                    .font(.title)
                    .foregroundStyle(.secondary)
                Text(game.startDate.shortStyle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            // Home
            VStack {
                Text(game.home.team)
                Text(game.home.conference)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text((game.home.lineScores?.first!)!)
            }
            
            Spacer()
        }
    }
}

#Preview {
    GameDetailsView(game: Game.mockGames[0])
        .appGradientBackground()
}
