//
//  test_for_Aezakmi_GroupApp.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import SwiftUI
import Firebase
import GoogleSignIn

@main
struct test_for_Aezakmi_GroupApp: App {
    @StateObject var userAuth: UserAuthModel = UserAuthModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(userAuth)
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
                .onAppear {
                    GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
                        userAuth.checkStatus()
                    }
                }
        }
    }
}
