//
//  PopoverSideMenu.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//

import SwiftUI

struct PopoverSideMenu<Content: View>: View {
    var content: Content
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.5)
                    .edgesIgnoringSafeArea(.all)
                
                content
            }
        }
    }
}
