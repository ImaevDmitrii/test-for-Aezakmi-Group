//
//  UserInfoView.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI

struct UserInfoView: View {
    @EnvironmentObject var viewModel: UserAuthModel
    @State private var showPhotoEditor = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text(String(format: Localization.welcomeUser, viewModel.givenName))
                    .font(.title)
                    .padding(.bottom, 20)
                
                if let url = URL(string: viewModel.profilePicUrl) {
                    AsyncImage(url: url)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                        .padding()
                }
                
                AuthButton(title: Localization.start) {
                    showPhotoEditor = true
                }
                
                AuthButton(title: Localization.logOut) {
                    viewModel.signOut()
                }
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .navigationTitle("")
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $showPhotoEditor) {
                PhotoEditorView()
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView().environmentObject(UserAuthModel())
    }
}
