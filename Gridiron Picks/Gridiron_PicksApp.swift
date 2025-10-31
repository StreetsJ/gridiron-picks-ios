//
//  Gridiron_PicksApp.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

@main
struct Gridiron_PicksApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var currentUserViewModel = CurrentUserViewModel()
    @StateObject private var appSettingsManager = AppSettingsManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(currentUserViewModel)
                .environmentObject(appSettingsManager)
        }
    }
}
