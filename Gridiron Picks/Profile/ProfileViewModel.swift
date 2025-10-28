//
//  ProfileViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//

import Foundation
import Combine // For @Published and Cancellables

class ProfileViewModel: ObservableObject {
    // This will hold the current user's profile data, mirrored from CurrentUserViewModel
    @Published var currentUserProfile: UserProfileModel?
    @Published var friends: [Friend] = []
    @Published var isLoadingFriends: Bool = false
    @Published var friendsErrorMessage: String?

    private let friendService = FriendService()
    private var cancellables = Set<AnyCancellable>()
    
    init(with currentUserVM: CurrentUserViewModel) {
        // Set up a Combine pipeline to listen for changes in the current user's profile
        currentUserVM.$userProfile
            .sink { [weak self] userProfile in
                guard let self = self else { return }
                self.currentUserProfile = userProfile // Update our local copy

                // If a user profile is available, try to fetch friends
                if let uid = userProfile?.id {
                    self.fetchFriends(forUserID: uid)
                } else {
                    // If user signs out or profile becomes nil, clear friends
                    self.friends = []
                    self.friendsErrorMessage = nil
                }
            }
            .store(in: &cancellables) // Store the subscription to prevent it from being deallocated
    }
    
    func reloadFriends() {
        if let id = currentUserProfile?.id {
            fetchFriends(forUserID: id)
        }
    }

    private func fetchFriends(forUserID userID: String) {
        isLoadingFriends = true
        friendsErrorMessage = nil

        friendService.getFriends(forUserID: userID) { [weak self] result in
            DispatchQueue.main.async { // Ensure UI updates are on the main thread
                guard let self = self else { return }
                self.isLoadingFriends = false

                switch result {
                case .success(let fetchedFriends):
                    self.friends = fetchedFriends
                case .failure(let error):
                    self.friendsErrorMessage = error.localizedDescription
                    print("Error fetching friends for \(userID): \(error.localizedDescription)")
                }
            }
        }
    }
}
