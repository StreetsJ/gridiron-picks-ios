//
//  ContentView.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var authVM = AuthViewModel()
    
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
        SportsAppMock()
    }
}

#Preview {
    ContentView()
}
