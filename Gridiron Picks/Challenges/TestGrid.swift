//
//  TestGrid.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/13/25.
//

import SwiftUI

struct User2 {
    let id = UUID()
    let name: String
    var votes: [String] // Array of team names they voted for
}

struct UserVotesGridView: View {
    @State private var users: [User2] = [
        User2(name: "Alice", votes: ["Lakers", "Warriors", "Bulls", "Heat"]),
        User2(name: "Bob", votes: ["Warriors", "Lakers", "Celtics", "Nets"]),
        User2(name: "Charlie", votes: ["Bulls", "Heat", "Lakers", "Warriors"]),
        User2(name: "Diana", votes: ["Heat", "Bulls", "Warriors", "Lakers"]),
        User2(name: "Eve", votes: ["Celtics", "Nets", "Heat", "Bulls"])
    ]
    
    let gameCount = 4 // Number of games
    
    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical]) {
                HStack(alignment: .top, spacing: 8) {
                    // Each column represents a user
                    ForEach(users, id: \.id) { user in
                        VStack(spacing: 4) {
                            // User name header
                            Text(user.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding(.vertical, 12)
                                .padding(.horizontal, 8)
                                .frame(minWidth: 100)
                                .background(Color.blue.opacity(0.2))
                                .cornerRadius(8)
                            
                            // User's votes for each game
                            ForEach(0..<gameCount, id: \.self) { gameIndex in
                                VStack {
                                    Text("Game \(gameIndex + 1)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    
                                    Text(user.votes.indices.contains(gameIndex) ? user.votes[gameIndex] : "N/A")
                                        .font(.body)
                                        .fontWeight(.medium)
                                }
                                .padding(.vertical, 10)
                                .padding(.horizontal, 8)
                                .frame(minWidth: 100, minHeight: 60)
                                .background(
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(Color.gray.opacity(0.1))
                                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                                )
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("User Team Votes")
        }
    }
    
    private func createColumns() -> [GridItem] {
        return Array(repeating: GridItem(.flexible(minimum: 100)), count: users.count)
    }
}

// Alternative implementation using a more traditional table-like layout
struct TableStyleUserVotesView: View {
    @State private var users: [User2] = [
        User2(name: "Alice", votes: ["Lakers", "Warriors", "Bulls", "Heat"]),
        User2(name: "Bob", votes: ["Warriors", "Lakers", "Celtics", "Nets"]),
        User2(name: "Charlie", votes: ["Bulls", "Heat", "Lakers", "Warriors"]),
        User2(name: "Diana", votes: ["Heat", "Bulls", "Warriors", "Lakers"]),
        User2(name: "Eve", votes: ["Celtics", "Nets", "Heat", "Bulls"])
    ]
    
    let gameCount = 4
    
    var body: some View {
        NavigationView {
            ScrollView([.horizontal, .vertical]) {
                VStack(alignment: .leading, spacing: 0) {
                    // Header row
                    HStack(spacing: 0) {
                        Text("Game")
                            .font(.headline)
                            .fontWeight(.bold)
                            .frame(width: 80, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .border(Color.gray, width: 1)
                        
                        ForEach(users, id: \.id) { user in
                            Text(user.name)
                                .font(.headline)
                                .fontWeight(.bold)
                                .frame(width: 100, height: 50)
                                .background(Color.blue.opacity(0.2))
                                .border(Color.gray, width: 1)
                        }
                    }
                    
                    // Game rows
                    ForEach(0..<gameCount, id: \.self) { gameIndex in
                        HStack(spacing: 0) {
                            Text("Game \(gameIndex + 1)")
                                .font(.body)
                                .fontWeight(.medium)
                                .frame(width: 80, height: 60)
                                .background(Color.gray.opacity(0.1))
                                .border(Color.gray, width: 1)
                            
                            ForEach(users, id: \.id) { user in
                                Text(user.votes.indices.contains(gameIndex) ? user.votes[gameIndex] : "N/A")
                                    .font(.body)
                                    .frame(width: 100, height: 60)
                                    .background(Color.white)
                                    .border(Color.gray, width: 1)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Team Votes Table")
        }
    }
}

// Preview
struct Main: View {
    var body: some View {
        TabView {
            UserVotesGridView()
                .tabItem {
                    Label("Grid Style", systemImage: "grid")
                }
            
            TableStyleUserVotesView()
                .tabItem {
                    Label("Table Style", systemImage: "tablecells")
                }
        }
    }
}

#Preview {
    Main()
}
