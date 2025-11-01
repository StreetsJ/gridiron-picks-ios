//
//  ViewExtensions.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/7/25.
//

import SwiftUI

struct AppGradientBackground: ViewModifier {
    var challengeStatus: ChallengeStatus? = nil
    
    let defaultColors = [
        Color(red: 0.1, green: 0.5, blue: 0.8),  // Bright blue
        Color(red: 0.05, green: 0.1, blue: 0.4), // Darker blue
        Color(red: 0.02, green: 0.05, blue: 0.2)  // Very dark blue
    ]
    
    // TODO: try to standarize with function from challenge row view
    func getBackgroundGradient(for challengeStatus: ChallengeStatus) -> [Color] {
        switch challengeStatus {
        case .voting:
            return [Color(.systemPink).opacity(0.3), Color(.systemPink).opacity(0.1)]
        case .picking:
            return [Color(.systemPurple).opacity(0.3), Color(.systemPurple).opacity(0.1)]
        case .closed:
            return [Color(.systemMint).opacity(0.3), Color(.systemMint).opacity(0.1)]
        case .completed:
            return defaultColors
        }
    }
    
    func getColors() -> [Color] {
        if challengeStatus != nil {
            return self.getBackgroundGradient(for: challengeStatus!)
        } else {
            return defaultColors
        }
    }
    
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(
                    colors: getColors()
                ),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            content
        }
        .preferredColorScheme(.dark)
    }
}

struct SecondaryGradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack(alignment: .top) {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.8, blue: 0.5),  // Bright blue
                    Color(red: 0.05, green: 0.4, blue: 0.1), // Darker blue
                    Color(red: 0.02, green: 0.2, blue: 0.05)  // Very dark blue
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            content
        }
        .preferredColorScheme(.dark)
    }
}

struct ListContainerBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
        .background(Color.black.opacity(0.3))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.horizontal, 16)
        .shadow(color: .black.opacity(0.15), radius: 12, x: 0, y: 6)
    }
}

extension View {
    func appGradientBackground(for challengeStatus: ChallengeStatus? = nil) -> some View {
        modifier(AppGradientBackground(challengeStatus: challengeStatus))
    }
    func secondaryGradientBackground() -> some View {
        modifier(SecondaryGradientBackground())
    }
    func listContainerBackground() -> some View {
        modifier(ListContainerBackground())
    }
}
