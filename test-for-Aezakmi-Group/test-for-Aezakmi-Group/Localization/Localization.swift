//
//  Localization.swift
//  test-for-Aezakmi-Group
//
//  Created by Dmitrii Imaev on 05.08.2024.
//

import Foundation

struct Localization {
    static var helloAgain: String { "helloAgain".localized }
    static var welcomeBack: String { "welcomeBack".localized }
    static var emailText: String { "emailText".localized }
    static var passwordText: String { "passwordText".localized }
    static var forgotPassword: String { "forgotPassword".localized }
    static var loginText: String { "loginText".localized }
    static var orText: String { "orText".localized }
    static var dontHaveAccount: String { "dontHaveAccount".localized }
    static var createAccount: String { "createAccount".localized }
    static var signUpToGetStarted: String { "signUpToGetStarted".localized }
    static var confirmPassword: String { "confirmPassword".localized }
    static var signUpText: String { "signUpText".localized }
    static var resetPassword: String { "resetPassword".localized }
    static var enterEmailForReset: String { "enterEmailForReset".localized }
    static var sendResetLink: String { "sendResetLink".localized }
    static var welcomeUser: String { "welcomeUser".localized }
    static var errorText: String { "errorText".localized }
    static var okText: String { "okText".localized }
    static var logInWithGoogle: String { "logInWithGoogle".localized }
    static var rememberMe: String { "rememberMe".localized }
    static var passwordMismatch: String { "passwordMismatch".localized }
    static var tapToSelectImage: String { "tapToSelectImage".localized }
    static var selectImage: String { "selectImage".localized }
    static var takePhoto: String { "takePhoto".localized }
    static var addText: String { "addText".localized }
    static var applyFilter: String { "applyFilter".localized }
    static var save: String { "save".localized }
    static var photoEditor: String { "photoEditor".localized }
    static var selectFilter: String { "selectFilter".localized }
    static var passwordReset: String { "passwordReset".localized }
    static var cancel: String { "cancel".localized }
    static var logInTitle: String { "logInTitle".localized }
    static var logInSubtitle: String { "logInSubtitle".localized }
    static var start: String { "start".localized }
    static var logOut: String { "logOut".localized }
    static var enterText: String { "enterText".localized }
    static var blur: String { "blur".localized }
    static var photoEditingTitle: String { "photoEditingTitle".localized }
    static var add: String { "add".localized }
    static var bold: String { "bold".localized }
    static var normal: String { "normal".localized }
    static var message: String { "message".localized }
    static var saved: String { "saved".localized }
    static var successSave: String { "successSave".localized }
    static var cameraAccess: String { "cameraAccess".localized }
}

extension String {
    var localized: String {
        let lang = UserDefaults.standard.string(forKey: "language") ?? "en"
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else { return self }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
