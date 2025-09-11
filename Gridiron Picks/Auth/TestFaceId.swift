//
//  TestFaceId.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/10/25.
//

import SwiftUI

struct FaceIDAnimationView: View {
    @State private var isScanning = false
    @State private var showSuccess = false
    @State private var scanProgress: CGFloat = 0
    @State private var checkmarkProgress: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(spacing: 30) {
                ZStack {
                    // Face ID scanning frame
                    FaceIDFrame(progress: scanProgress, showSuccess: showSuccess)
                    
                    // Success checkmark
//                    if showSuccess {
//                        CheckmarkView(progress: checkmarkProgress)
//                    }
                }
                .frame(width: 200, height: 200)
                
                Text(showSuccess ? "Authentication Successful" : "Face ID")
                    .foregroundColor(.white)
                    .font(.title2)
                    .fontWeight(.medium)
                
                Button(action: startAnimation) {
                    Text("Authenticate")
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .background(Color.blue)
                        .cornerRadius(25)
                }
                .disabled(isScanning)
            }
        }
    }
    
    private func startAnimation() {
        // Reset states
        showSuccess = false
        scanProgress = 0
        checkmarkProgress = 0
        isScanning = true
        
        // Start scanning animation
        withAnimation(.easeInOut(duration: 2.0)) {
            scanProgress = 1.0
        }
        
        // Show success after scanning
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showSuccess = true
            
            withAnimation(.easeInOut(duration: 0.6)) {
                checkmarkProgress = 1.0
            }
            
            // Reset after showing success
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                isScanning = false
                showSuccess = false
                scanProgress = 0
                checkmarkProgress = 0
            }
        }
    }
}

struct FaceIDFrame: View {
    let progress: CGFloat
    let showSuccess: Bool
    
    var body: some View {
        ZStack {
            // Corner brackets
            ForEach(0..<4) { index in
                CornerBracket(
                    position: CornerPosition.allCases[index],
                    color: showSuccess ? .green : .white
                )
            }
            
            // Scanning lines
            if !showSuccess && progress > 0 {
                ScanningLines(progress: progress)
            }
        }
    }
}

struct CornerBracket: View {
    let position: CornerPosition
    let color: Color
    
    var body: some View {
        Path { path in
            let size: CGFloat = 30
            let thickness: CGFloat = 3
            
            switch position {
            case .topLeft:
                // Horizontal line
                path.move(to: CGPoint(x: -100, y: -100))
                path.addLine(to: CGPoint(x: -100 + size, y: -100))
                // Vertical line
                path.move(to: CGPoint(x: -100, y: -100))
                path.addLine(to: CGPoint(x: -100, y: -100 + size))
                
            case .topRight:
                path.move(to: CGPoint(x: 100, y: -100))
                path.addLine(to: CGPoint(x: 100 - size, y: -100))
                path.move(to: CGPoint(x: 100, y: -100))
                path.addLine(to: CGPoint(x: 100, y: -100 + size))
                
            case .bottomLeft:
                path.move(to: CGPoint(x: -100, y: 100))
                path.addLine(to: CGPoint(x: -100 + size, y: 100))
                path.move(to: CGPoint(x: -100, y: 100))
                path.addLine(to: CGPoint(x: -100, y: 100 - size))
                
            case .bottomRight:
                path.move(to: CGPoint(x: 100, y: 100))
                path.addLine(to: CGPoint(x: 100 - size, y: 100))
                path.move(to: CGPoint(x: 100, y: 100))
                path.addLine(to: CGPoint(x: 100, y: 100 - size))
            }
        }
        .stroke(color, lineWidth: 3)
    }
}

struct ScanningLines: View {
    let progress: CGFloat
    
    var body: some View {
        ZStack {
            ForEach(0..<8) { index in
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [.clear, .white.opacity(0.8), .clear],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .frame(width: 200, height: 2)
                    .offset(y: -80 + (CGFloat(index) * 20) + (progress * 160))
                    .opacity(progress > 0 ? 0.6 : 0)
            }
        }
        .clipped()
    }
}

enum CornerPosition: CaseIterable {
    case topLeft, topRight, bottomLeft, bottomRight
}

#Preview {
    FaceIDAnimationView()
}
