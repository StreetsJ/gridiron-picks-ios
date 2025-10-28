//
//  ProfileView.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/13/25.
//

import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    // Access the shared CurrentUserViewModel from the environment
    @EnvironmentObject var currentUserVM: CurrentUserViewModel

    // Create the ProfileViewModel, injecting the CurrentUserViewModel
    @StateObject private var profileViewModel: ProfileViewModel

    // Custom initializer to pass the EnvironmentObject to the StateObject's init
    init(currentUserVM: CurrentUserViewModel) {
        _profileViewModel = StateObject(wrappedValue: ProfileViewModel(with: currentUserVM))
    }
    
    var body: some View {
        if let user = currentUserVM.userProfile {
            Text("Hello, \(user.displayName ?? "User")!")
                if profileViewModel.isLoadingFriends {
                    ProgressView("Loading Friends...")
                } else if let errorMessage = profileViewModel.friendsErrorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.orange)
                            .padding(.bottom, 5)
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            profileViewModel.reloadFriends()
                        }
                        .padding()
                        .background(Capsule().fill(Color.blue))
                        .foregroundColor(.white)
                    }
                    .padding()
                } else if profileViewModel.friends.isEmpty {
                    VStack {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .padding(.bottom, 5)
                        Text("You don't have any friends yet!")
                            .foregroundColor(.secondary)
                        Button("Find Friends") {
                            // TODO: Navigate to a screen to add friends
                            print("Navigate to Find Friends screen")
                        }
                        .padding()
                        .background(Capsule().fill(Color.green))
                        .foregroundColor(.white)
                    }
                    .padding()
                } else {
                    ForEach(profileViewModel.friends) { friend in
                        HStack {
                            Image(systemName: "person.circle.fill") // Placeholder for a profile image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.accentColor)
                                .clipShape(Circle())
                            
                            VStack(alignment: .leading) {
                                Text(friend.displayName)
                                    .font(.headline)
                                Text("Added at: \(friend.addedAt.shortStyle)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            // You could add more info here, e.g., a "Challenge" button
                            // Button("Challenge") { print("Challenge \(friend.displayName)") }
                        }
                        .padding()
                    }
                }
        }
    }
}
