//
//  AddChallengeView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//
import SwiftUI

struct AddChallengeView: View {
    @EnvironmentObject var currentUserViewModel: CurrentUserViewModel
    
//    @StateObject var profileViewModel: ProfileViewModel
//    @StateObject var addChallengeViewModel: AddChallengeViewModel
//    
//    init(profileViewModel: ProfileViewModel) {
//        self.profileViewModel = profileViewModel
//        
//        _addChallengeViewModel = StateObject(wrappedValue: AddChallengeViewModel(friends: profileViewModel.friends))
//    }
//    
    // TODO: friends view
    var body: some View {
        if let _ = currentUserViewModel.userProfile {
            Text("Add Challenge")
        }
    }
}
