//
//  GameRowView.swift
//  Gridiron Picks
//
//  Created by James Streets on 10/28/25.
//

import SwiftUI

struct GameRowView: View {
    let game: FBGameModel
    
    var body: some View {
        ZStack{
            HStack(alignment: .top) {
                VStack {
                    Spacer()
                    
                    TeamTitleView(rank: game.awayRank, name: game.awayTeam)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                }
                VStack {
                    Text(game.startDate.shortestStyle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(game.startDate.localizedTime)
                    
                    Spacer()
                    
                    let formattedSpread = if (game.spread > 0) {
                        "\(game.awayTeam) \(game.spread)"
                    } else {
                        "\(game.homeTeam) \(game.spread)"
                    }
                    
                    Text(formattedSpread)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                VStack {
                    Spacer()
                    
                    TeamTitleView(rank: game.homeRank, name: game.homeTeam)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    Spacer()
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
}
