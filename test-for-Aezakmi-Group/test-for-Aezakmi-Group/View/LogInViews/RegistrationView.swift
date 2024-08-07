//
//  RegistrationView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI

struct RegistrationView: View {
    @EnvironmentObject var viewModel: UserAuthModel
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPhotoEditor = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(Localization.createAccount)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Text(Localization.signUpToGetStarted)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                TextField(Localization.emailText, text: $email)
                    .modifier(TextFieldModifier())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField(Localization.passwordText, text: $password)
                    .modifier(TextFieldModifier())
                
                SecureField(Localization.confirmPassword, text: $confirmPassword)
                    .modifier(TextFieldModifier())
                
                Button(action: {
                    guard password == confirmPassword else {
                        viewModel.errorMessage = Localization.passwordMismatch
                        return
                    }
                    viewModel.signUpWithEmail(email: email, password: password)
                }) {
                    Text(Localization.signUpText)
                }
                .modifier(ButtonModifier())
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .navigationTitle("")
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

struct RegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView().environmentObject(UserAuthModel())
    }
}
