//
//  CFBDataManager.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import Foundation

class CFBDataManager: ObservableObject {
    @Published var games: [Game] = []
    
    init(mockGames: [Game] = []) {
        self.games = mockGames
    }
    
    private let apiKey = "Uedy3yaRnJtnmRSHIx14HmazWwlLaQiVdd46649fTd7HaNXQtb0Xnbgz4w4DivXw"
    
    func fetchTop25Games(week: Int, year: Int = 2025) async {
//        guard let url = URL(string: "https://api.collegefootballdata.com/games?year=\(year)&week=\(week)&seasonType=regular&conference=sec") else { return }
//        
//        var request = URLRequest(url: url)
//        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            
//            let decodedGames = try JSONDecoder().decode([Game].self, from: data)
            
            let decodedGames = Game.mockGames
            
            // Optional: filter only top 25 teams
            // For simplicity, assume API already has top teams (or you fetch rankings separately)
            DispatchQueue.main.async {
                self.games = decodedGames
            }
        } catch {
            print("❌ Error fetching games:", error)
        }
    }
}
