//
//  UserModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 9/7/25.
//

import Foundation
import FirebaseFirestore

struct AppUser: Decodable, Identifiable {
    @DocumentID var id: String?
    var displayName: String
    var email: String
}
