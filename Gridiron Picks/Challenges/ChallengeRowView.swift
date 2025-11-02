//
//  ChallengeRowView.swift
//  Gridiron Picks
//
//  Created by James Streets on 11/1/25.
//

import SwiftUI

struct ChallengeRowView: View {
    let challenge: ChallengeModel
    let player1DisplayName: String
    let player2DisplayName: String
    
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [Color.getColor(for: self.challenge.getStatus()), Color.black]), startPoint: .topTrailing, endPoint: .bottomLeading)
            VStack(alignment: .leading, spacing: 8) {
                Text(verbatim: "Season \(challenge.seasonYear)")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.2))
                    .foregroundColor(.green)
                    .cornerRadius(4)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Players")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Text("\(player1DisplayName)")
                                .font(.footnote)
                            Text("\(challenge.player1Wins)-\(challenge.player1Ties)-\(challenge.player1Losses)")
                                .font(.footnote)
                            Spacer()
                        }
                        
                        HStack {
                            Text("\(player2DisplayName)")
                                .font(.footnote)
                            Text("\(challenge.player2Wins)-\(challenge.player2Ties)-\(challenge.player2Losses)")
                                .font(.footnote)
                            Spacer()
                        }
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("Games")
                            .font(.caption)
                            .foregroundColor(.secondary)
                        
                        Text("\(challenge.gameIds.count)")
                            .font(.headline)
                            .fontWeight(.bold)
                    }
                }
            }
            .padding()
        }
    }
}
