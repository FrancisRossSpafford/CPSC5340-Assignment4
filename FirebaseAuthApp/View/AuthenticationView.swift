//
//  ContentView.swift
//  FirebaseAuthApp
//
//  Created by Ross Spafford on 4/13/25.
//
//  Simple app to demonstrate firebase authentication.
//

import SwiftUI

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthViewModel()
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 16) {
            if let user = viewModel.user {
                Text("Welcome!")
                    .font(.title)
                Text("Sign in successful.").font(.subheadline)
                Text("User ID: \(user.email ?? "User")").font(.subheadline)
                Text(user.uid).font(.footnote)
                Button("Sign Out") {
                    viewModel.signOut()
                }
            } else {
                Text("Firebase Authentication Demo")
                    .font(.title)
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Sign Up") {
                    viewModel.signUp(email: email, password: password)
                }

                Button("Log In") {
                    viewModel.logIn(email: email, password: password)
                }

                if !viewModel.errorMessage.isEmpty {
                    Text("Error: \(viewModel.errorMessage)")
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
    }
}
