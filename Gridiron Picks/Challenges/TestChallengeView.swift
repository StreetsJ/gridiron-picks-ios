//
//  TestChallengeView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/7/25.
//

import SwiftUI

struct TestChallengeView: View {
    
    var body: some View {
        NavigationView {
            List {
                ForEach(ChallengeModel.mockChallenges, id: \.title) { challenge in
                    NavigationLink(destination: ChallengeDetails(
                        challenge: challenge,
                        title: challenge.title,
                        player1DisplayName: challenge.player1Id,
                        player2DisplayName: challenge.player2Id
                    )) {
                        HStack {
                            Text(challenge.title)
                                .font(.headline)
                            Spacer()
                            VStack(alignment: .leading) {
                                Text(challenge.player1Id)
                                Text(challenge.player2Id)
                            }
                        }
    //                    ChallengeRowView(
    //                        challenge: challenge,
    //                        player1DisplayName: challenge.player1Id,
    //                        player2DisplayName: challenge.player2Id
    //                    )
                    }
                }
            }

        }
        .preferredColorScheme(.dark)
        .background(.ultraThinMaterial)
    }
}
