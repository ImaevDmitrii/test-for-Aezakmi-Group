//
//  LoginView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI
import GoogleSignInSwift

struct LoginView: View {
    @EnvironmentObject var viewModel: UserAuthModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPhotoEditor = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(Localization.logInTitle)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(Localization.logInSubtitle)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                AuthTextField(placeholder: Localization.emailText, text: $email)
                AuthSecureField(placeholder: Localization.passwordText, text: $password)
                
                AuthButton(title: Localization.loginText) {
                    viewModel.signInWithEmail(email: email, password: password)
                }
                
                AuthButton(title: Localization.logInWithGoogle) {
                    viewModel.signIn()
                }
                
                NavigationLink(destination: RegistrationView()) {
                    Text(Localization.dontHaveAccount)
                        .foregroundColor(.blue)
                }
                NavigationLink(destination: ForgotPasswordView()) {
                    Text(Localization.forgotPassword)
                        .foregroundColor(.blue)
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showPhotoEditor) {
                PhotoEditorView()
            }
            .onReceive(viewModel.$isLoggedIn) { isLoggedIn in
                if isLoggedIn {
                    showPhotoEditor = true
                }
            }
            .onReceive(viewModel.$errorMessage) { errorMessage in
                if !errorMessage.isEmpty {
                    alertMessage = errorMessage
                    showAlert = true
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text(Localization.errorText), message: Text(alertMessage), dismissButton: .default(Text(Localization.okText)))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserAuthModel())
    }
}
