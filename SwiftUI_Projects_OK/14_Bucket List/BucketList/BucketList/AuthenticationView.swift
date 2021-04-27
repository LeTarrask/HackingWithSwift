//
//  AuthenticationView.swift
//  BucketList
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @State private var isUnlocked = false

    @State private var alertError = false
    @State private var errorTitle = ""
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            if isUnlocked {
                ContentView()
            } else {
                Button("Unlock Places") {
                    authenticate()
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
            }

        }
        .alert(isPresented: $alertError) {
            Alert(title: Text(errorTitle),
                  message: Text(errorMessage),
                  primaryButton: .cancel(Text("Cancel")),
                  secondaryButton: .default(Text("Try again")) {
                    authenticate()
                  }
            )
        }
    }

    // MARK: - FaceID authentication
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics
                                   , localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        isUnlocked = true
                    } else {
                        errorTitle = "Autentication error"
                        errorMessage = "Couldn't autenticate your identity"
                        alertError = true
                    }
                }
            }
        } else {
            errorTitle = "There is no biometric data"
            errorMessage = "Couldn't autenticate your identity"
            alertError = true
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
    }
}
