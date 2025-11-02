//
//  ChallengeDetails.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/7/25.
//

import SwiftUI

struct ChallengeDetails: View {
    @StateObject private var viewModel = NextWeekViewModel()
    
    let challenge: ChallengeModel
    let title: String
    let player1DisplayName: String
    let player2DisplayName: String
    let games: [FBGameModel] = FBGameModel.mockGames
    
    @State private var progress: CGFloat = 0.0
    @State private var showBottomSheet: Bool = false
    @State private var showPopover: Bool = false

    @State private var selectedTab = "This Week"
    let tabs = ["Last Week", "This Week", "Next Week"]

    @State private var selectedLeague = "Top 25"
    let leagues = ["Top 25", "ACC", "Big 10", "Big 12", "SEC"]
    
    func getTitle(for challengeStatus: ChallengeStatus) -> String {
        switch challengeStatus {
        case .voting:
            return "Voting"
        case .picking:
            return "Picking"
        case .closed:
            return "Closed"
        case .completed:
            return "Completed"
        }
    }
    
    
    var body: some View {
        ZStack {
            // Dimming overlay that animates with the bottom sheet
            Color.black
                .opacity(showBottomSheet ? 0.6 : 0)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.25), value: showBottomSheet)
                .zIndex(1)
                .allowsHitTesting(showBottomSheet)
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        showBottomSheet = false
                    }
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
                        HStack(spacing: 8) {
                            Text("\(self.getTitle(for: self.challenge.getStatus())) Stage")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .background(Color.black.opacity(0.3))
                        
                        Divider()
                            .background(Color.white.opacity(0.2))
                        
                        // Games list
                        ScrollView(showsIndicators: false) {
                            LazyVStack(spacing: 1) {
                                switch self.challenge.getStatus() {
                                case .voting:
                                    ForEach(viewModel.games, id: \.id) { game in
                                        GamePollRow(game: game)
                                            .onTapGesture(perform: {
                                                showBottomSheet.toggle()
                                            })
                                            .sheet(isPresented: $showBottomSheet) {
                                                GameDetailsView(game: game)
                                                    .secondaryGradientBackground()
                                                    .presentationDetents([.medium])
                                                    .presentationDragIndicator(.visible)
                                            }
                                    }
                                case .picking:
                                    ForEach(games, id: \.id) { game in
                                        TeamSelectorView(homeTeam: game.homeTeam, awayTeam: game.awayTeam, game: game)
                                            .padding()
                                    }
                                case .closed:
                                    ForEach(games, id: \.id) { game in
                                        GameRowView(game: game)
                                    }
                                case .completed:
                                    PastWeek()
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
        }
        .preferredColorScheme(.dark)
        .padding()
        
    }
}
    


#Preview {
//    ZStack {
//        Color.blue
//            .ignoresSafeArea()
//        ChallengeDetails(challenge: ChallengeModel.mockChallenges.first!, title: "Let's Go Challenge", player1DisplayName: "You", player2DisplayName: "Zach")
//    }
}
