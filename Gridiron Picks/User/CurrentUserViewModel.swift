//
//  CurrentUserViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import Combine // For @Published and Cancellables

class CurrentUserViewModel: ObservableObject {
    @Published var userProfile: UserProfileModel?
    @Published var isLoadingUserProfile: Bool = false
    @Published var userProfileErrorMessage: String?

    private var authStateDidChangeListenerHandle: AuthStateDidChangeListenerHandle?
    private var userProfileListener: ListenerRegistration?
    private let db = Firestore.firestore()

    init() {
        setupAuthChangeListener()
    }

    deinit {
        // Remove listeners when the ViewModel is deallocated
        if let handle = authStateDidChangeListenerHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
        userProfileListener?.remove()
    }

    private func setupAuthChangeListener() {
        authStateDidChangeListenerHandle = Auth.auth().addStateDidChangeListener { [weak self] auth, user in
            guard let self = self else { return }

            if let user = user {
                // User is signed in, start listening for their profile data
                print("Auth state changed: User \(user.uid) signed in. Starting profile listener.")
                self.startUserProfileListener(for: user.uid)
            } else {
                // User is signed out, clear profile data and remove listener
                print("Auth state changed: User signed out. Clearing profile.")
                self.userProfile = nil
                self.userProfileErrorMessage = nil
                self.userProfileListener?.remove()
                self.userProfileListener = nil
            }
        }
    }

    private func startUserProfileListener(for uid: String) {
        isLoadingUserProfile = true
        userProfileErrorMessage = nil

        // Remove any existing listener first to prevent duplicates
        userProfileListener?.remove()

        // Listen for real-time updates to the user's profile document
        userProfileListener = db.collection("users").document(uid)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                guard let self = self else { return }
                self.isLoadingUserProfile = false

                if let error = error {
                    self.userProfileErrorMessage = "Error fetching user profile: \(error.localizedDescription)"
                    print(self.userProfileErrorMessage!)
                    self.userProfile = nil // Clear stale data on error
                    return
                }

                guard let document = documentSnapshot else {
                    self.userProfileErrorMessage = "User profile document not found."
                    print(self.userProfileErrorMessage!)
                    self.userProfile = nil
                    return
                }

                do {
                    // Decode the document directly into our UserProfile struct
                    print("duck - user doc = \(document.exists) \(document.documentID)")
                    self.userProfile = try document.data(as: UserProfileModel.self)
                    print("User profile updated/fetched successfully: \(self.userProfile?.displayName ?? "Unknown User")")
                } catch {
                    self.userProfileErrorMessage = "Error decoding user profile: \(error.localizedDescription)"
                    print(self.userProfileErrorMessage!)
                    self.userProfile = nil
                }
            }
    }
}
