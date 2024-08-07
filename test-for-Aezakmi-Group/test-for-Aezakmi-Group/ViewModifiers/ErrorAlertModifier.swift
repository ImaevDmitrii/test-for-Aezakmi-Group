//
//  ErrorAlertModifier.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 06.08.2024.
//

import SwiftUI

struct ErrorAlertModifier: ViewModifier {
    @Binding var errorMessage: String
    
    func body(content: Content) -> some View {
        content
            .alert(isPresented: .constant(!errorMessage.isEmpty)) {
                Alert(
                    title: Text(Localization.errorText),
                    message: Text(errorMessage),
                    dismissButton: .default(Text(Localization.okText), action: {
                        errorMessage = ""
                    })
                )
            }
    }
}

extension View {
    func errorAlert(errorMessage: Binding<String>) -> some View {
        self.modifier(ErrorAlertModifier(errorMessage: errorMessage))
    }
}
