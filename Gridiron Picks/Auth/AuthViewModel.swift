//
//  AuthViewModel.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthViewModel: ObservableObject {
    @Published var user: User? = nil
    
    init() {
        self.user = Auth.auth().currentUser
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("❌ Sign in error: \(error.localizedDescription)")
                return
            }
            self?.user = result?.user
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                print("❌ Sign up error: \(error.localizedDescription)")
                return
            }
            self?.user = result?.user
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch {
            print("❌ Sign out error: \(error.localizedDescription)")
        }
    }
}
