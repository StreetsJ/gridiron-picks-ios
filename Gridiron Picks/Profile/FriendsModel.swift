//
//  FriendsModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//

import Foundation
import FirebaseFirestore

struct Friend: Decodable, Identifiable {
    @DocumentID var id: String?
    let addedAt: Date
    let displayName: String
}
