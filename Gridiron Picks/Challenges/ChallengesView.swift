//
//  ChallengesView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/6/25.
//
import SwiftUI

struct ChallengesView: View {
    @StateObject private var viewModel = ChallengesViewModel()
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView("Loading challenges...")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .preferredColorScheme(.dark)
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Image(systemName: "exclamationmark.triangle")
                    .font(.largeTitle)
                    .foregroundColor(.orange)
                
                Text("Error loading challenges")
                    .font(.headline)
                
                Text(errorMessage)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                
                Button("Retry") {
                    viewModel.refreshChallenges()
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .preferredColorScheme(.dark)
        } else if viewModel.challenges.isEmpty {
            VStack(spacing: 16) {
                Image(systemName: "gamecontroller")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
                
                Text("No challenges yet")
                    .font(.headline)
                
                Text("Start a new challenge to get the competition going!")
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .padding()
            .preferredColorScheme(.dark)
        } else {
            ScrollView(showsIndicators: false) {
                LazyVStack(spacing: 1) {
                    ForEach(viewModel.challenges, id: \.title) { challenge in
                        let player1DisplayName = viewModel.getDisplayName(for: challenge.player1Id)
                        let player2DisplayName = viewModel.getDisplayName(for: challenge.player2Id)
                        NavigationLink(destination: ChallengeDetails(
                            challenge: challenge,
                            title: challenge.title,
                            player1DisplayName: player1DisplayName,
                            player2DisplayName: player2DisplayName
                        ).appGradientBackground()
                        ) {
                            ChallengeRowView(
                                challenge: challenge,
                                player1DisplayName: player1DisplayName,
                                player2DisplayName: player2DisplayName
                            )
                            .padding()
                        }
                    }
                }
                .listContainerBackground()
            }
            .preferredColorScheme(.dark)
//            .refreshable {
//                viewModel.refreshChallenges()
//            }
        }
    }
}

struct ChallengeRowView: View {
    let challenge: ChallengeModel
    let player1DisplayName: String
    let player2DisplayName: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Season \(challenge.seasonYear)")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(4)
                
                Text("Week \(challenge.week)")
                    .font(.caption)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.green.opacity(0.2))
                    .foregroundColor(.green)
                    .cornerRadius(4)
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Players")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text("Player 1: \(player1DisplayName)")
                        .font(.footnote)
                    
                    Text("Player 2: \(player2DisplayName)")
                        .font(.footnote)
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
        .padding(.vertical, 4)
    }
}

// Preview
struct ChallengesView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            
            ChallengesView()
        }
    }
}
