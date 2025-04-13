//
//  AuthViewModel.swift
//  FirebaseAuthApp
//
//  Created by Ross Spafford on 4/13/25.
//

import Foundation
import FirebaseAuth
import Combine

class AuthViewModel: ObservableObject {
    @Published var user: UserModel? = nil
    @Published var errorMessage: String = ""
    
    init() {
        self.user = getCurrentUser()
    }

    func getCurrentUser() -> UserModel? {
        guard let user = Auth.auth().currentUser else { return nil }
        return UserModel(uid: user.uid, email: user.email)
    }

    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }

            if let user = result?.user {
                DispatchQueue.main.async {
                    self?.user = UserModel(uid: user.uid, email: user.email)
                    self?.errorMessage = ""
                }
            }
        }
    }

    func logIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.errorMessage = error.localizedDescription
                }
                return
            }

            if let user = result?.user {
                DispatchQueue.main.async {
                    self?.user = UserModel(uid: user.uid, email: user.email)
                    self?.errorMessage = ""
                }
            }
        }
    }

    func signOut() {
        do {
            try Auth.auth().signOut()
            DispatchQueue.main.async {
                self.user = nil
            }
        } catch {
            DispatchQueue.main.async {
                self.errorMessage = error.localizedDescription
            }
        }
    }
}

