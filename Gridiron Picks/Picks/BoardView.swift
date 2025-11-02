//
//  Board.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/13/25.
//

import SwiftUI

struct BoardView: View {
    let games: [FBGameModel] = FBGameModel.mockGames
    
    var body: some View {
        VStack(spacing: 0) {
            // Games list
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 1) {
                    ForEach(self.games, id: \.id) { game in
                        TeamSelectorView(homeTeam: game.homeTeam, awayTeam: game.awayTeam, game: game)
                            .padding()
                        Text(game.startDate.shortStyle)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .background(Color.black.opacity(0.2))
        }
        .background(Color.black.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
    }
}
