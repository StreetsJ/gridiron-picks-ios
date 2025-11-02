//
//  ChallengeWeekPoll.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/10/25.
//
import SwiftUI

struct GamePollRow: View {
    let game: FBGameModel
    
    @State private var isSelected: Bool = false
    @State private var checkmarkProgress: CGFloat = 0
    @State private var showCheckmark: Bool = false

    var body: some View {
        ZStack{
            HStack(alignment: .top) {
                TeamTitleView(rank: game.awayRank, name: game.awayTeam)
                    .frame(maxWidth: .infinity, alignment: .leading)
                VStack {
                    Text(game.startDate.shortestStyle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(game.startDate.localizedTime)
                    
                    Spacer()
                    
                    let formattedSpread = if (game.spread > 0) {
                        "\(game.awayTeam) \(game.spread)"
                    } else {
                        "\(game.homeTeam) \(game.spread)"
                    }
                    
                    Text(formattedSpread)
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()

                    Button {
                        isSelected.toggle()
                        toggleAnimation()
                    } label: {
                        Text("Vote")
                            .foregroundColor(isSelected ? .green : .blue)
                    }
                }
                TeamTitleView(rank: game.homeRank, name: game.homeTeam)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            if (showCheckmark) {
                CheckmarkView(progress: checkmarkProgress, x: 300, y: 60)
            }
        }
        .padding()
        .background(isSelected ? .green.opacity(0.1) : Color.clear)
        .frame(maxWidth: .infinity, alignment: .trailing)
    }
    
    private func toggleAnimation() {
        showCheckmark.toggle()
        checkmarkProgress = showCheckmark ? 0 : 1
            
        if showCheckmark {
            withAnimation(.easeInOut(duration: 0.6)) {
                checkmarkProgress = showCheckmark ? 1 : 0
            }
        }
    }
}

struct TeamTitleView: View {
    let rank: Int?
    let name: String?
    
    private var rankK: String {
        if let rank = rank {
            return String(rank)
        } else {
            return ""
        }
    }
    
    var body: some View {
        Text("\(rankK) \(name ?? "")")
    }
}

struct CheckmarkView: View {
    let progress: CGFloat
    let x: CGFloat
    let y: CGFloat
    
    @State private var circleProgress: CGFloat = 0
    
    // Calculate checkmark bounds for perfect circle sizing
    private var checkmarkBounds: CGRect {
        let checkmarkWidth: CGFloat = 24  // -12 to +12
        let checkmarkHeight: CGFloat = 16 // -8 to +8
        return CGRect(
            x: -checkmarkWidth/2,
            y: -checkmarkHeight/2,
            width: checkmarkWidth,
            height: checkmarkHeight
        )
    }
    
    // Circle diameter should perfectly contain the checkmark with some padding
    private var circleDiameter: CGFloat {
        let padding: CGFloat = 16
        return max(checkmarkBounds.width, checkmarkBounds.height) + padding
    }
    
    var body: some View {
        ZStack {
            // Animated circle - perfectly sized to contain checkmark
            Circle()
                .trim(from: 0, to: circleProgress)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round))
                .frame(width: circleDiameter, height: circleDiameter)
                .rotationEffect(.degrees(-90)) // Start from top
                .animation(.easeInOut(duration: 0.4), value: circleProgress)
            
            // Checkmark - centered within the circle
            Path { path in
                let checkPath = UIBezierPath()
                
                // Create checkmark path (coordinates match checkmarkBounds)
                let startX = Int(x) - 140
                let startY = Int(y) - 7
                
                // Create checkmark path
                checkPath.move(to: CGPoint(x: startX, y: startY))
                // x + 10 ; y + 10
                checkPath.addLine(to: CGPoint(x: startX + 5, y: startY + 5))
                // x + 30 ; y - 20
                checkPath.addLine(to: CGPoint(x: startX + 15, y: startY - 10))
                
                path.addPath(Path(checkPath.cgPath))
            }
            .trim(from: 0, to: progress)
            .stroke(Color.green, style: StrokeStyle(lineWidth: 3, lineCap: .round, lineJoin: .round))
        }
        .position(x: x, y: y) // Position the entire view at specified coordinates
        .onAppear {
            // Start circle animation immediately
            withAnimation(.easeInOut(duration: 0.4)) {
                circleProgress = 1.0
            }
        }
        .onChange(of: progress) { _, newValue in
            if newValue == 0 {
                circleProgress = 0
            }
        }
    }
}


#Preview {
    let pos = 200.0
    ZStack {
        Color.blue
        CheckmarkView(progress: 1.0, x: pos, y: pos)
    }
}
