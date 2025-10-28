//
//  AuthView.swift
//  Gridiron Picks
//
//  Created by James Streets on 8/31/25.
//

import SwiftUI

struct AuthView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State private var email = ""
    @State private var password = ""
    @State private var isLogin = true
    
    var body: some View {
        VStack(spacing: 16) {
            TextField("Email", text: $email)
                .textFieldStyle(.roundedBorder)
                .autocapitalization(.none)
            
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button(isLogin ? "Sign In" : "Sign Up") {
                if isLogin {
                    authVM.signIn(email: email, password: password)
                } else {
                    authVM.signUp(email: email, password: password)
                }
            }
            .buttonStyle(.borderedProminent)
            
            Button(isLogin ? "Need an account? Sign Up" : "Have an account? Sign In") {
                isLogin.toggle()
            }
        }
        .preferredColorScheme(.light)
        .padding()
        .navigationTitle(isLogin ? "Sign In" : "Sign Up")
    }
}
