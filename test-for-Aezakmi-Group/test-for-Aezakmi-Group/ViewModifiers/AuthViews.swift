//
//  AuthViews.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 07.08.2024.
//

import SwiftUI

struct AuthTextField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .modifier(TextFieldModifier())
            .autocapitalization(.none)
            .disableAutocorrection(true)
    }
}

struct AuthSecureField: View {
    var placeholder: String
    @Binding var text: String
    
    var body: some View {
        SecureField(placeholder, text: $text)
            .modifier(TextFieldModifier())
    }
}

struct AuthButton: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .frame(maxWidth: .infinity) 
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
    }
}
