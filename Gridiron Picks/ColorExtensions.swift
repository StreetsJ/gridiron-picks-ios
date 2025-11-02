//
//  ColorExtensions.swift
//  Gridiron Picks
//
//  Created by James Streets on 11/1/25.
//

import SwiftUI

extension Color {
    
    /**
     Initializes a Color from a standard 6-digit hexadecimal string.
     - Parameter hex: The hex string, optionally including the '#' prefix (e.g., "#FF6B6B" or "FF6B6B").
     - Parameter opacity: The opacity of the color (default is 1.0).
     */
    init(hex: String, opacity: Double = 1.0) {
        
        // 1. Clean the string: remove whitespace and the '#'
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        // 2. Ensure it's a 6-digit hex string
        guard hexSanitized.count == 6 else {
            // Fallback to a noticeable color (like a dark gray) if the hex is invalid
            self.init(.sRGB, red: 0.5, green: 0.5, blue: 0.5, opacity: 1.0)
            return
        }

        var rgb: UInt64 = 0
        
        // 3. Scan the hex string to get the 64-bit integer value
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        // 4. Extract the Red, Green, and Blue components using bitwise operations
        let red = Double((rgb >> 16) & 0xFF) / 255.0
        let green = Double((rgb >> 8) & 0xFF) / 255.0
        let blue = Double(rgb & 0xFF) / 255.0
        
        // 5. Initialize the SwiftUI Color
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

extension Color {
    static let votingBG: Color = Color(.systemPink).mix(with: Color(red: 0.05, green: 0.1, blue: 0.4), by: 0.6)
    static let pickingBG: Color = Color(.systemPurple).mix(with: Color(red: 0.05, green: 0.1, blue: 0.4), by: 0.6)
    static let closedBG: Color = Color(.systemMint).mix(with: Color(red: 0.05, green: 0.1, blue: 0.4), by: 0.6)
    static let completedBG: Color = Color(.systemGreen).mix(with: Color(red: 0.05, green: 0.1, blue: 0.4), by: 0.6)
    
    static func getColor(for challengeStatus: ChallengeStatus) -> Color {
        switch challengeStatus {
        case .voting:
            return Color.votingBG
        case .picking:
            return Color.pickingBG
        case .closed:
            return Color.closedBG
        case .completed:
            return Color.completedBG
        }
    }
}


