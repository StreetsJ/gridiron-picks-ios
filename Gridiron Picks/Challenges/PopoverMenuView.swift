//
//  PopoverMenuView.swift
//  Gridiron Picks
//
//  Created by James Streets on 10/28/25.
//

import SwiftUI

struct PopoverMenuView: View {
    @State var selectedLeague: String = "My Picks"
    @State var leagues: [String] = ["My Picks", "Board"]
    @State var showPopover: Bool = false
    
    @Namespace private var animation
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            // Popover
            Group {
                if showPopover {
                    VStack {
                        ForEach(leagues, id: \.self) { league in
                            Button(action: {
                                selectedLeague = league
                                withAnimation(.spring()) {
                                    showPopover.toggle()
                                }
                            }) {
                                Text(league)
                            }
                            //                            .foregroundStyle(selectedLeague == league .gray)
                        }
                    }
                    .padding(.horizontal)
                    .matchedGeometryEffect(id: "showPopover", in: animation)
                } else {
                    Button(action: {
                        withAnimation(.spring()) {
                            showPopover.toggle()
                        }
                    }) {
                        HStack {
                            Text(selectedLeague)
                            Image(systemName: "line.horizontal.3")
                                .resizable()
                                .frame(width: 10, height: 5)
                        }
                        .matchedGeometryEffect(id: "showButton", in: animation)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 5)
            .foregroundStyle(.white)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle.rect(cornerRadius: 10)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Create a matching rounded rectangle
                    .stroke(Color.white.opacity(0.3), lineWidth: 1) // Apply the stroke (border)
            )
            .zIndex(2)
//            
//            VStack(alignment: .trailing) {
//                Group {
//                    switch selectedLeague {
//                    case "My Picks":
//                        MyPicksView()
//                    case "Board":
//                        BoardView()
//                    default:
//                        MyPicksView()
//                    }
//                }
//            }
//            .padding(.vertical, 40)
        }
    }
}
