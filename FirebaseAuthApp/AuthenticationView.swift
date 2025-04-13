//
//  ContentView.swift
//  FirebaseAuthApp
//
//  Created by Ross Spafford on 4/13/25.
//
//  Simple app to demonstrate firebase authentication.
//

import SwiftUI
import FirebaseAuth

struct AuthenticationView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isSignedIn = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 16) {
            if isSignedIn {
                Text("Welcome!").font(.title)
                Text("Sign In Successful.").font(.subheadline)
                Button("Log Out") {
                    try? Auth.auth().signOut()
                    isSignedIn = false
                }
            } else {
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Sign Up") {
                    Auth.auth().createUser(withEmail: email, password: password) { result, error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                        } else {
                            isSignedIn = true
                        }
                    }
                }

                Button("Log In") {
                    Auth.auth().signIn(withEmail: email, password: password) { result, error in
                        if let error = error {
                            errorMessage = error.localizedDescription
                        } else {
                            isSignedIn = true
                        }
                    }
                }

                if !errorMessage.isEmpty {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                }
            }
        }
        .padding()
        .onAppear {
            isSignedIn = Auth.auth().currentUser != nil
        }
    }
}
