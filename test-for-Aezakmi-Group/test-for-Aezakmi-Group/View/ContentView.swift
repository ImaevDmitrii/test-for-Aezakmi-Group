//
//  ContentView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct ContentView: View {
    @EnvironmentObject var viewModel: UserAuthModel
    
    var body: some View {
        NavigationStack {
            if viewModel.isLoggedIn {
                UserInfoView()
            } else {
                LoginView()
            }
        }
        .errorAlert(errorMessage: $viewModel.errorMessage)
        .onAppear {
            viewModel.checkStatus()
        }
        .navigationDestination(isPresented: $viewModel.isLoggedIn) {
            PhotoEditorView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(UserAuthModel())
    }
}
