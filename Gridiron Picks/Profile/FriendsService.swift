//
//  FriendsService.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//

import Foundation
import FirebaseFirestore
import Combine // For @Published and Cancellables

// MARK: - Custom Error Handling
enum FriendServiceError: LocalizedError {
    case notAuthenticated
    case firestoreError(Error)
    case decodingError(Error)

    var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "No authenticated user found. Please log in."
        case .firestoreError(let error):
            return "Firestore error: \(error.localizedDescription)"
        case .decodingError(let error):
            return "Error decoding friend data: \(error.localizedDescription)"
        }
    }
}

// MARK: - Friend Fetching Function
class FriendService {
    private let db = Firestore.firestore()

    /// Fetches the friends for a given user ID from Firestore's 'friends' subcollection.
    /// - Parameter userID: The UID of the user whose friends are to be fetched.
    /// - Parameter completion: A closure that returns a Result containing an array of Friend objects or an error.
    func getFriends(forUserID userID: String, completion: @escaping (Result<[Friend], FriendServiceError>) -> Void) {
        db.collection("users").document(userID).collection("friends")
            .getDocuments { (querySnapshot, error) in
                if let error = error {
                    completion(.failure(.firestoreError(error)))
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    completion(.success([]))
                    return
                }

                let friends = documents.compactMap { doc -> Friend? in
                    do {
                        return try doc.data(as: Friend.self)
                    } catch {
                        print("Error decoding friend document \(doc.documentID): \(error.localizedDescription)")
                        return nil
                    }
                }

                let sortedFriends = friends.sorted { $0.displayName < $1.displayName }
                completion(.success(sortedFriends))
            }
    }
}
