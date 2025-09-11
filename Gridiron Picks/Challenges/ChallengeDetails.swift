//
//  ChallengeDetails.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/7/25.
//

import SwiftUI

struct ChallengeDetails: View {
    let challenge: ChallengeModel
    let title: String
    let player1DisplayName: String
    let player2DisplayName: String
    let games: [Game] = Game.mockGames
    
    @State private var progress: CGFloat = 0.0
    @State private var showBottomSheet: Bool = false
    @State private var selectedTab = "Week 1"
    let tabs = ["Week 0", "Week 1", "Week 2"]
    
    
    var body: some View {
        ZStack {
            if showBottomSheet {
                Color.black.opacity(0.6)
                    .edgesIgnoringSafeArea(.all)
                    .zIndex(1)
                    .transition(.opacity)
            }
            
            VStack {
                HStack {
                    Text(player1DisplayName)
                        .font(.title)
                    Spacer()
                    Text(player2DisplayName)
                        .font(.title)
                }
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
                                ForEach(games, id: \.id) { game in
                                    if selectedTab == "Week 2" {
                                        GamePollRow(game: game)
                                            .onTapGesture(perform: {
                                                showBottomSheet.toggle()
                                            })
                                            .sheet(isPresented: $showBottomSheet, onDismiss: {
                                                debugPrint(">>> Dismissed bottom sheet")
                                            }) {
                                                GameDetailsView(game: game)
                                                    .secondaryGradientBackground()
                                                    .presentationDetents([.medium])
                                                    .presentationDragIndicator(.visible)
                                            }
                                    } else {
                                        TeamSelectorView(homeTeam: game.home.team, awayTeam: game.away.team)
                                            .padding()
                                        Text(game.startDate.shortStyle)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                }
                            }
                            .animation(.easeInOut, value: selectedTab)
                        }
                        .background(Color.black.opacity(0.2))
                    }
                    .background(Color.black.opacity(0.3))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
                }
            }
            .preferredColorScheme(.dark)
            .padding()
        }
    }
    
//    func gamesForSelectedTab() -> [Game] {
//        switch selectedTab {
//        case "Week 0":
//            return yesterdayGames
//        case "Week 1":
//            return todayGames
//        case "Week 2":
//            return upcomingGames
//        default:
//            return todayGames
//        }
//    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        ChallengeDetails(challenge: ChallengeModel.mockChallenges.first!, title: "Let's Go Challenge", player1DisplayName: "You", player2DisplayName: "Zach")
    }
}
