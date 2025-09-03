//
//  TeamSelectorView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/1/25.
//

import SwiftUI

struct TeamSelectorView: View {
    @State private var selectedTeam: TeamSelection = .none
    
    var homeTeam: String
    var awayTeam: String
    
    enum TeamSelection {
        case away, home, none
    }
    
    var body: some View {
        HStack {
            // Away Team
            Text(awayTeam)
                .foregroundColor(selectedTeam == .away ? .green : (selectedTeam == .home ? .red : .primary))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedTeam == .away ? Color.green.opacity(0.2) : Color.clear)
                )
                .onTapGesture {
                    selectedTeam = selectedTeam == .away ? .none : .away
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                        
            // @ Symbol
            Text("@")
                .foregroundColor(.secondary)
                .frame(width: 20, alignment: .center)
                        
            // Home Team
            Text(homeTeam)
                .foregroundColor(selectedTeam == .home ? .green : (selectedTeam == .away ? .red : .primary))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(selectedTeam == .home ? Color.green.opacity(0.2) : Color.clear)
                )
                .onTapGesture {
                    selectedTeam = selectedTeam == .home ? .none : .home
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .background(Color.clear)
    }
}

#Preview {
    TeamSelectorView(homeTeam: "Ohio State", awayTeam: "Texas")
}
