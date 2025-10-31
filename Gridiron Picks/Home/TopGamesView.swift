//
//  Challenge20View.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/13/25.
//

import SwiftUI

struct TopGamesView: View {
    @EnvironmentObject var appSettings: AppSettingsManager
    @StateObject var viewModel: TopGamesViewModel
    
    init(appSettings: AppSettingsManager) {
        _viewModel = StateObject(wrappedValue: TopGamesViewModel(appSettings: appSettings))
    }

    var body: some View {
        if let _ = viewModel.games {
            VStack(spacing: 0) {
                Text("Top 25 Games - Week \(appSettings.currentCFBWeek)")
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.black.opacity(0.3))
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 1) {
                        ForEach(viewModel.games!) { game in
                            GameRowView(game: game)
                            Divider()
                        }
                    }
                }
                .background(Color.black.opacity(0.2))
            }
            .background(Color.black.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
            .padding(.horizontal)
        }
    }
}

#Preview {
//    TopGamesView()
}
