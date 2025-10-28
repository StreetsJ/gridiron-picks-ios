//
//  UserProfileModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/16/25.
//

import Foundation
import FirebaseFirestore

struct UserProfileModel: Identifiable, Decodable {
    @DocumentID var id: String?
    var displayName: String?
    var email: String?
    var friendUids: [String]?
}
