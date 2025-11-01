//
//  ContentView.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel
    @EnvironmentObject var appSettingsManager: AppSettingsManager
    @StateObject var authViewModel = AuthViewModel()
    
    @State private var selectedTab = 0
    let tabs = ["Gridiron Picks", "Challenges", "Profile"]
    
    @State private var showAddChallenge: Bool = false
    
    var body: some View {
        NavigationStack {
            if let _ = currentUserViewModel.userProfile {
                NavigationStack {
                    NavigationView {
                        VStack {
                            HStack {
                               let title = if tabs[selectedTab] == "Challenges" {
                                   "Week \(appSettingsManager.currentCFBWeek)"
                                } else {
                                    "\(tabs[selectedTab])"
                                }
                                Text(title)
                                    .font(.largeTitle.bold())

                                Spacer()

                                if selectedTab == 1 {
                                    Image(systemName: "plus")
                                        .onTapGesture {
                                            showAddChallenge = true
                                        }
                                } else if selectedTab == 2 {
                                    Button {
                                        authViewModel.signOut()
                                    } label: {
                                        Text("Sign Out")
                                            .foregroundStyle(.red)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            

                            switch selectedTab {
                            case 0:
                                TopGamesView(appSettings: appSettingsManager)
                            case 1:
                                ChallengesView()
                                    .sheet(isPresented: $showAddChallenge) {
                                        AddChallengeView()
                                            .appGradientBackground()
                                    }
                            case 2:
                                ProfileView(currentUserVM: currentUserViewModel) // need to pass in viewmodel because enviornment objects are injected after view initialization
                            default:
                                TopGamesView(appSettings: appSettingsManager)
                            }
                            
                            Spacer()
                            Spacer()
                            
                            // Custom tab bar
                            HStack {
                                Spacer()
                                
                                Button(action: {
                                    selectedTab = 0
                                }) {
                                    VStack(spacing: 4) {
                                        Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                                            .font(.system(size: 24))
                                        Text("Home")
                                            .font(.caption)
                                    }
                                    .foregroundColor(selectedTab == 0 ? .white : .white.opacity(0.6))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedTab = 1
                                }) {
                                    VStack(spacing: 4) {
                                        Image(systemName: selectedTab == 1 ? "gamecontroller.fill" : "gamecontroller")
                                            .font(.system(size: 24))
                                        Text("Challenges")
                                            .font(.caption)
                                    }
                                    .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.6))
                                }
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedTab = 2
                                }) {
                                    VStack(spacing: 4) {
                                        Image(systemName: selectedTab == 2 ? "person.fill" : "person")
                                            .font(.system(size: 24))
                                        Text("Profile")
                                            .font(.caption)
                                    }
                                    .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.6))
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(
                                Rectangle()
                                    .fill(Color.black.opacity(0.1))
                                    .blur(radius: 20)
                            )
                        }
                        .appGradientBackground()
                        .navigationBarHidden(true)
                        .toolbarColorScheme(.light, for: .navigationBar)
                        .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
                        .preferredColorScheme(.dark)
                    }
                }
            } else {
                AuthView()
                    .appGradientBackground()
            }
        }
        .environmentObject(authViewModel)
    }
}

#Preview {
//    ContentView()
}
