//
//  ContentView.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

struct ContentView: View {
//    @StateObject private var authVM = AuthViewModel()
    
    @State private var selectedTab = 0
    let tabs = ["Gridiron Picks", "Challenges"]
    
    var body: some View {
//        NavigationStack {
//            if let _ = authVM.user {
//                NavigationStack {
//                    HomeView()
//                    
//                    Button("Sign Out") {
//                        authVM.signOut()
//                    }
//                }
//                .padding()
//                .navigationTitle("Gridiron Picks")
//            } else {
//                AuthView()
//            }
//        }
//        .environmentObject(authVM)
        NavigationView {
            VStack {
                Group {
                    switch selectedTab {
                    case 0:
                        SportsAppMock()
                    case 1:
                        ChallengesView()
                    default:
                        SportsAppMock()
                    }
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
                           Image(systemName: selectedTab == 1 ? "person.fill" : "person")
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
            .navigationTitle(tabs[selectedTab])
            .navigationBarTitleDisplayMode(.large)
            .toolbarColorScheme(.light, for: .navigationBar)
            .toolbarBackground(.ultraThinMaterial, for: .navigationBar)
        }
        .preferredColorScheme(.dark)
    }
}

//struct ContentView: View {
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        ZStack {
//            // Gradient background for the entire app
//            LinearGradient(
//                gradient: Gradient(colors: [
//                    Color.blue.opacity(0.8),
//                    Color.purple.opacity(0.6),
//                    Color.pink.opacity(0.4)
//                ]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .ignoresSafeArea(.all)
//            
//            // Custom TabView implementation
//            VStack {
//                // Content area
//                Group {
//                    if selectedTab == 0 {
//                        HomeTabView()
//                    } else {
//                        ProfileTabView()
//                    }
//                }
//                .frame(maxWidth: .infinity, maxHeight: .infinity)
//                
//                Spacer()
//                
//                // Custom tab bar
//                HStack {
//                    Spacer()
//                    
//                    Button(action: {
//                        selectedTab = 0
//                    }) {
//                        VStack(spacing: 4) {
//                            Image(systemName: selectedTab == 0 ? "house.fill" : "house")
//                                .font(.system(size: 24))
//                            Text("Home")
//                                .font(.caption)
//                        }
//                        .foregroundColor(selectedTab == 0 ? .white : .white.opacity(0.6))
//                    }
//                    
//                    Spacer()
//                    
//                    Button(action: {
//                        selectedTab = 1
//                    }) {
//                        VStack(spacing: 4) {
//                            Image(systemName: selectedTab == 1 ? "person.fill" : "person")
//                                .font(.system(size: 24))
//                            Text("Profile")
//                                .font(.caption)
//                        }
//                        .foregroundColor(selectedTab == 1 ? .white : .white.opacity(0.6))
//                    }
//                    
//                    Spacer()
//                }
//                .padding(.horizontal, 20)
//                .padding(.vertical, 20)
//                .background(
//                    Rectangle()
//                        .fill(Color.black.opacity(0.1))
//                        .blur(radius: 20)
//                )
//            }
//        }
//    }
//}
//
//struct HomeTabView: View {
//    var body: some View {
//        VStack(spacing: 30) {
//            Text("Home Tab")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//            
//            VStack(spacing: 15) {
//                Text("Welcome to the Home tab!")
//                    .font(.title2)
//                    .multilineTextAlignment(.center)
//                
//                Text("This view inherits the gradient background from its parent ContentView.")
//                    .font(.body)
//                    .multilineTextAlignment(.center)
//                    .opacity(0.9)
//            }
//            .foregroundColor(.white)
//            .padding(.horizontal, 20)
//            
//            Button(action: {
//                // Button action
//            }) {
//                Text("Home Action")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(
//                        RoundedRectangle(cornerRadius: 10)
//                            .fill(Color.white.opacity(0.2))
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 10)
//                                    .stroke(Color.white.opacity(0.3), lineWidth: 1)
//                            )
//                    )
//            }
//            
//            Spacer()
//        }
//        .padding(.top, 50)
//    }
//}
//
//struct ProfileTabView: View {
//    var body: some View {
//        VStack(spacing: 30) {
//            // Profile image placeholder
//            Circle()
//                .fill(Color.white.opacity(0.3))
//                .frame(width: 100, height: 100)
//                .overlay(
//                    Image(systemName: "person.fill")
//                        .font(.system(size: 40))
//                        .foregroundColor(.white.opacity(0.7))
//                )
//            
//            Text("Profile Tab")
//                .font(.largeTitle)
//                .fontWeight(.bold)
//                .foregroundColor(.white)
//            
//            VStack(spacing: 15) {
//                Text("Your Profile Information")
//                    .font(.title2)
//                    .multilineTextAlignment(.center)
//                
//                Text("This tab also inherits the same beautiful gradient background, creating a consistent visual experience throughout the app.")
//                    .font(.body)
//                    .multilineTextAlignment(.center)
//                    .opacity(0.9)
//            }
//            .foregroundColor(.white)
//            .padding(.horizontal, 20)
//            
//            VStack(spacing: 10) {
//                ProfileRow(title: "Name", value: "John Doe")
//                ProfileRow(title: "Email", value: "john@example.com")
//                ProfileRow(title: "Location", value: "San Francisco")
//            }
//            .padding(.horizontal, 20)
//            
//            Spacer()
//        }
//        .padding(.top, 50)
//    }
//}
//
//struct ProfileRow: View {
//    let title: String
//    let value: String
//    
//    var body: some View {
//        HStack {
//            Text(title)
//                .font(.headline)
//                .foregroundColor(.white.opacity(0.8))
//            
//            Spacer()
//            
//            Text(value)
//                .font(.body)
//                .foregroundColor(.white)
//        }
//        .padding(.vertical, 8)
//        .padding(.horizontal, 15)
//        .background(
//            RoundedRectangle(cornerRadius: 8)
//                .fill(Color.white.opacity(0.1))
//                .overlay(
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
//                )
//        )
//    }
//}

#Preview {
    ContentView()
}
