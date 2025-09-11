//
//  ViewExtensions.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/7/25.
//

import SwiftUI

struct AppGradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.5, blue: 0.8),  // Bright blue
                    Color(red: 0.05, green: 0.1, blue: 0.4), // Darker blue
                    Color(red: 0.02, green: 0.05, blue: 0.2)  // Very dark blue
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

struct SecondaryGradientBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
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
    func appGradientBackground() -> some View {
        modifier(AppGradientBackground())
    }
    func secondaryGradientBackground() -> some View {
        modifier(SecondaryGradientBackground())
    }
    func listContainerBackground() -> some View {
        modifier(ListContainerBackground())
    }
}
