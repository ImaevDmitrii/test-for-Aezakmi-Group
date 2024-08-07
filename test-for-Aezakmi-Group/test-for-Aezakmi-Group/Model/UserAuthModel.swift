//
//  UserAuthModel.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

final class UserAuthModel: ObservableObject {
    @Published var givenName: String = ""
    @Published var profilePicUrl: String = ""
    @Published var isLoggedIn: Bool = false
    @Published var errorMessage: String = ""

    init() {
        checkStatus()
    }
    
    func checkStatus() {
        if let user = GIDSignIn.sharedInstance.currentUser {
            self.givenName = user.profile?.givenName ?? ""
            self.profilePicUrl = user.profile?.imageURL(withDimension: 100)?.absoluteString ?? ""
            self.isLoggedIn = true
        } else if let currentUser = Auth.auth().currentUser {
            self.givenName = currentUser.email ?? ""
            self.isLoggedIn = true
        } else {
            self.isLoggedIn = false
            self.givenName = ""
            self.profilePicUrl = ""
        }
    }
    
    func signIn() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signInResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = Localization.errorText + ": " + error.localizedDescription
                }
                return
            }
            
            guard let user = signInResult?.user else { return }
            let idToken = user.idToken?.tokenString
            let accessToken = user.accessToken.tokenString
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken ?? "", accessToken: accessToken)
            
            Auth.auth().signIn(with: credential) { authResult, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.errorMessage = Localization.errorText + ": " + error.localizedDescription
                    }
                } else {
                    DispatchQueue.main.async {
                        self.checkStatus()
                    }
                }
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            self.errorMessage = "Error signing out: \(signOutError.localizedDescription)"
        }
        self.checkStatus()
    }
    
    func signUpWithEmail(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Sign up error: \(error.localizedDescription)"
                }
                return
            }
            DispatchQueue.main.async {
                self.checkStatus()
            }
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Sign in error: \(error.localizedDescription)"
                }
                return
            }
            DispatchQueue.main.async {
                self.checkStatus()
            }
        }
    }
}
