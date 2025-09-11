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
    @State private var activeGame: Game? = nil
    @State private var selectedTab = "This Week"
    let tabs = ["Last Week", "This Week", "Next Week"]
    
    
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
                    // Clear selected content after the dismiss animation finishes
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        activeGame = nil
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
                                    switch selectedTab {
                                    case "Last Week":
                                        PastWeek
                                    case "This Week":
                                        TeamSelectorView(homeTeam: game.home.team, awayTeam: game.away.team)
                                            .padding()
                                        Text(game.startDate.shortStyle)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    case "Next Week":
                                        GamePollRow(game: game)
                                            .onTapGesture(perform: {
                                                activeGame = game
                                                withAnimation(.easeInOut(duration: 0.25)) {
                                                    showBottomSheet = true
                                                }
                                            })
                                        
//                                        GamePollRow(game: game)
//                                            .onTapGesture(perform: {
//                                                showBottomSheet.toggle()
//                                            })
//                                         .sheet(isPresented: $showBottomSheet, onDismiss: {
//                                                debugPrint(">>> Dismissed bottom sheet")
//                                            }) {
//                                                GameDetailsView(game: game)
//                                                    .secondaryGradientBackground()
//                                                    .presentationDetents([.medium])
//                                                    .presentationDragIndicator(.visible)
//                                            }
                                    default:
                                        Text("Default")
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

            // Custom bottom sheet
            if let activeGame = activeGame {
                BottomSheet(isPresented: $showBottomSheet) {
                    GameDetailsView(game: activeGame)
                }
                .zIndex(2)
                .onChange(of: showBottomSheet) { _, newValue in
                    if newValue == false {
                        // Clear after the closing animation completes
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.activeGame = nil
                        }
                    }
                }
            }
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

// MARK: - Reusable BottomSheet
struct BottomSheet<Content: View>: View {
    @Binding var isPresented: Bool
    let content: Content
    @GestureState private var dragOffset: CGFloat = 0

    init(isPresented: Binding<Bool>, @ViewBuilder content: () -> Content) {
        self._isPresented = isPresented
        self.content = content()
    }

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                // Drag indicator
                Capsule()
                    .fill(Color.white.opacity(0.4))
                    .frame(width: 40, height: 5)
                    .padding(.top, 8)
                    .padding(.bottom, 8)

                content
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            }
            .secondaryGradientBackground()
            .frame(maxWidth: .infinity)
            .background(Color(uiColor: .systemBackground).opacity(0.9))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(0.2), radius: 20, x: 0, y: -8)
            .offset(y: sheetOffset(totalHeight: geometry.size.height))
            .animation(.easeInOut(duration: 0.25), value: isPresented)
            .animation(.spring(response: 0.35, dampingFraction: 0.85), value: dragOffset)
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        let translation = max(0, value.translation.height)
                        state = translation
                    }
                    .onEnded { value in
                        let translation = value.translation.height
                        let velocity = value.velocity.height
                        let shouldClose = translation > 120 || velocity > 700
                        if shouldClose {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                isPresented = false
                            }
                        }
                    }
            )
        }
        .ignoresSafeArea(edges: .bottom)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }

    private func sheetOffset(totalHeight: CGFloat) -> CGFloat {
        let baseOffset = isPresented ? max(0, dragOffset) : totalHeight + 40
        return baseOffset
    }
}

#Preview {
    ZStack {
        Color.blue
            .ignoresSafeArea()
        ChallengeDetails(challenge: ChallengeModel.mockChallenges.first!, title: "Let's Go Challenge", player1DisplayName: "You", player2DisplayName: "Zach")
    }
}
