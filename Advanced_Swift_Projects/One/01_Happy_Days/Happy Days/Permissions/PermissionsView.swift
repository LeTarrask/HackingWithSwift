//
//  PermissionsView.swift
//  Happy Days
//
//  Created by tarrask on 22/06/2021.
//

import SwiftUI

struct PermissionsView: View {
    let permissionsVC = PermissionsVC()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Please authorize us to use your phone capabilities.")
            Button("Ask for permissions") {
                requestPermissions()
            }
            if permissionsVC.authorized {
                Button("Dismiss") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
    }
    
    func requestPermissions() {
        permissionsVC.requestPermissions()
    }
}

struct PermissionsView_Previews: PreviewProvider {
    static var previews: some View {
        PermissionsView()
    }
}
