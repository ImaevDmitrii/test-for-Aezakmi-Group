//
//  ForgotPasswordView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Text(Localization.resetPassword)
                    .font(.title)
                    .padding(.bottom, 20)
                
                Text(Localization.enterEmailForReset)
                    .modifier(SubtitleModifier())
                
                TextField(Localization.emailText, text: $email)
                    .modifier(TextFieldModifier())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                Button(action: {
                    Auth.auth().sendPasswordReset(withEmail: email) { error in
                        if let error = error {
                            alertMessage = error.localizedDescription
                        } else {
                            alertMessage = "\(Localization.passwordReset)\(email)"
                        }
                        showingAlert = true
                    }
                }) {
                    Text(Localization.sendResetLink)
                }
                .modifier(ButtonModifier())
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text(Localization.resetPassword), message: Text(alertMessage), dismissButton: .default(Text(Localization.okText)))
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .navigationTitle("")
            .navigationBarHidden(false)
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
