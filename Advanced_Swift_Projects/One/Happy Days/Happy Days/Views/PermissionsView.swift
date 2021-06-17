//
//  ContentView.swift
//  Happy Days
//
//  Created by Alex Luna on 16/06/2021.
//

import SwiftUI

struct PermissionsView: View {
    @Environment(\.presentationMode) var presentationMode

    @StateObject var permissionsController = PermissionsController()

    var body: some View {
        VStack {
            Text("In order to work fully, Happy Days needs to read your photo library, record your voice, and transcribe what you said. When you click the button below you will be asked to grant those permissions, but you can change your mind later in Settings.")
                    .padding()

            Button("Continue") {
                if PermissionsController.canProcceed {
                    presentationMode.wrappedValue.dismiss()
                } else {
                    permissionsController.requestPermissions()
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView()
    }
}
