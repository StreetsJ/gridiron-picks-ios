//
//  AppSettingsManager.swift
//  Gridiron Picks
//
//  Created by James Streets on 10/29/25.
//

import SwiftUI
import FirebaseRemoteConfig // Assuming you use Remote Config

class AppSettingsManager: ObservableObject {
    // 1. Initial value is read instantly from UserDefaults
    @Published var currentCFBWeek: Int = UserDefaults.standard.integer(forKey: "currentCFBWeek")

    init() {
        // Fetch the latest value upon initialization
        fetchRemoteConfig()
    }

    func fetchRemoteConfig() {
        // --- Step 1: Fetch the value from the backend ---
        let remoteConfig = RemoteConfig.remoteConfig()
        
        remoteConfig.fetchAndActivate { [weak self] (status, error) in
            guard let self = self, status != .error else { return }

            let latestWeek = remoteConfig.configValue(forKey: "cfb_current_week").numberValue.intValue

            // --- Step 2: Update UserDefaults & publish the change ---
            if latestWeek > 0 && latestWeek != self.currentCFBWeek {
                print("Updated currentCFBWeek to: \(latestWeek)")
                UserDefaults.standard.set(latestWeek, forKey: "currentCFBWeek")
                // This updates all subscribing views immediately
                DispatchQueue.main.async {
                    self.currentCFBWeek = latestWeek
                }
            }
        }
    }
}
