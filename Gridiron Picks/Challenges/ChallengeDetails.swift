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
    let games: [Game] = Game.mockGames
    
    @State private var progress: CGFloat = 0.0
    @State private var showBottomSheet: Bool = false
    @State private var showPopover: Bool = false

    @State private var selectedTab = "This Week"
    let tabs = ["Last Week", "This Week", "Next Week"]

    @State private var selectedLeague = "Top 25"
    let leagues = ["Top 25", "ACC", "Big 10", "Big 12", "SEC"]
    
    
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
                    
                    //                    if selectedTab == "Next Week" {
                    //                        Group {
                    //                            if showPopover {
                    //                                VStack {
                    //                                    ForEach(leagues, id: \.self) { league in
                    //                                        Button(action: {
                    //                                            selectedLeague = league
                    //                                            showPopover.toggle()
                    //                                        }) {
                    //                                            Text(league)
                    //                                        }
                    //                                    }
                    //                                }
                    //                                .padding(.horizontal)
                    //                                .padding(.vertical, 5)
                    //                                .foregroundStyle(.white)
                    //                                .background(.black.opacity(0.1))
                    //                                .clipShape(RoundedRectangle.rect(cornerRadius: 10)
                    //                                )
                    //                                .overlay(
                    //                                    RoundedRectangle(cornerRadius: 10) // Create a matching rounded rectangle
                    //                                        .stroke(Color.white.opacity(0.3), lineWidth: 1) // Apply the stroke (border)
                    //                                )
                    //                                .transition(.move(edge: .trailing))
                    //                            } else {
                    //                                Button(action: {
                    //                                    withAnimation(.spring()) {
                    //                                        showPopover.toggle()
                    //                                    }
                    //                                }) {
                    //                                    HStack {
                    //                                        Text(selectedLeague)
                    //                                            .font(.caption)
                    //                                        Image(systemName: "line.horizontal.3")
                    //                                            .resizable()
                    //                                            .frame(width: 10, height: 5)
                    //                                    }
                    //                                    .padding(.horizontal)
                    //                                    .padding(.vertical, 5)
                    //                                    .foregroundStyle(.white)
                    //                                    .background(.black.opacity(0.1))
                    //                                    .clipShape(RoundedRectangle.rect(cornerRadius: 10)
                    //                                    )
                    //                                    .overlay(
                    //                                        RoundedRectangle(cornerRadius: 10) // Create a matching rounded rectangle
                    //                                            .stroke(Color.white.opacity(0.3), lineWidth: 1) // Apply the stroke (border)
                    //                                    )
                    //                                }
                    //                            }
                    //                        }
                    //                        .frame(alignment: .topTrailing)
                    //                    }
                    
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
                                    .frame(maxWidth: .infinity)
                                }
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
                                switch selectedTab {
                                case "Last Week":
                                    PastWeek()
                                case "This Week":
                                    ForEach(games, id: \.id) { game in
                                        TeamSelectorView(homeTeam: game.home.team, awayTeam: game.away.team)
                                            .padding()
                                        Text(game.startDate.shortStyle)
                                            .font(.subheadline)
                                            .foregroundColor(.secondary)
                                    }
                                case "Next Week":
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
                                default:
                                    Text("Default")
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
        }
        //        .toolbar {
        //            ToolbarItem(placement: .topBarTrailing) {
        //                if showPopover {
        //                    VStack {
        //                        ForEach(leagues, id: \.self) { league in
        //                            Button(action: {
        //                                selectedLeague = league
        //                                withAnimation(.spring()) {
        //                                    showPopover.toggle()
        //                                }
        //                            }) {
        //                                Text(league)
        //                            }
        //                            //                            .foregroundStyle(selectedLeague == league .gray)
        //                        }
        //                    }
        //                    .transition(.move(edge: .trailing))
        //                } else {
        //                    Button(action: {
        //                        withAnimation(.spring()) {
        //                            showPopover.toggle()
        //                        }
        //                    }) {
        //                        HStack {
        //                            Text(selectedLeague)
        //                                .font(.caption)
        //                            Spacer()
        //                            Image(systemName: "line.horizontal.3")
        //                                .resizable()
        //                                .frame(width: 10, height: 5)
        //                        }
        //                        .padding(.horizontal)
        //                        .padding(.vertical, 5)
        //                        .foregroundStyle(.white)
        //                        .background(.black.opacity(0.1))
        //                        .clipShape(RoundedRectangle.rect(cornerRadius: 10)
        //                        )
        //                        .overlay(
        //                            RoundedRectangle(cornerRadius: 10) // Create a matching rounded rectangle
        //                                .stroke(Color.white.opacity(0.3), lineWidth: 1) // Apply the stroke (border)
        //                        )
        //                    }
        //                }
        //            }
        //        }
        //        .overlay(alignment: .topTrailing) {
        //            if showPopover {
        //                VStack {
        //                    ForEach(leagues, id: \.self) { league in
        //                        Button(action: {
        //                            selectedLeague = league
        //                            withAnimation(.spring()) {
        //                                showPopover.toggle()
        //                            }
        //                        }) {
        //                            Text(league)
        //                        }
        //                        //                            .foregroundStyle(selectedLeague == league .gray)
        //                    }
        //                }
        //                .transition(.move(edge: .trailing))
        //            } else {
        //                Button(action: {
        //                    withAnimation(.spring()) {
        //                        showPopover.toggle()
        //                    }
        //                }) {
        //                    HStack {
        //                        Text(selectedLeague)
        //                            .font(.caption)
        //                        Image(systemName: "line.horizontal.3")
        //                            .resizable()
        //                            .frame(width: 10, height: 5)
        //                    }
        //                    .padding(.horizontal)
        //                    .padding(.vertical, 5)
        //                    .foregroundStyle(.white)
        //                    .background(.black.opacity(0.1))
        //                    .clipShape(RoundedRectangle.rect(cornerRadius: 10)
        //                    )
        //                    .overlay(
        //                        RoundedRectangle(cornerRadius: 10) // Create a matching rounded rectangle
        //                            .stroke(Color.white.opacity(0.3), lineWidth: 1) // Apply the stroke (border)
        //                    )
        //                }
        //            }
        //        }
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
