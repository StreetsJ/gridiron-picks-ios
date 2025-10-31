//
//  TopGamesViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 10/25/25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth
import Foundation

class TopGamesViewModel: ObservableObject {
    let year: Int = 2025
    var appSettings: AppSettingsManager
    
    @Published var games: [FBGameModel]? = nil
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    init(appSettings: AppSettingsManager) {
        self.appSettings = appSettings
        Task {
            await loadData()
        }
    }
    
    @MainActor
    private func loadData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let db = Firestore.firestore()
            let querySnapshot = try await db.collection("games")
                .whereField("week", isEqualTo: self.appSettings.currentCFBWeek)
                .whereField("seasonYear", isEqualTo: self.year)
                .getDocuments()
            
            var decodedGames: [FBGameModel] = []
            
            for document in querySnapshot.documents {
                do {
                    var game = try document.data(as: FBGameModel.self)
                    game.id = document.documentID
                    decodedGames.append(game)
                } catch {
                    print("Error decoding game: \(error)")
                }
            }
            
            games = decodedGames.sorted(by: { prev, next in
                prev.startDate < next.startDate
            })
            
            print("top games: \(!games?.isEmpty ?? false)")
            
            games?.forEach { game in
                print("\(game.awayTeam)")
                print("\(game.homeTeam)")
            }
            
            isLoading = false
        } catch {
            print("Error getting games: \(error.localizedDescription)")
            errorMessage = error.localizedDescription
            isLoading = false
        }
    }
}
