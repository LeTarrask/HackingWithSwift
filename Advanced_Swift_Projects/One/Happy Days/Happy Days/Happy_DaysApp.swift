//
//  Happy_DaysApp.swift
//  Happy Days
//
//  Created by Alex Luna on 16/06/2021.
//

import SwiftUI

@main
struct Happy_DaysApp: App {
    @State private var showingSheet = false
    
    var body: some Scene {
        WindowGroup {
            MemoryCollection()
                .onAppear(perform: checkPermissions)
                .sheet(isPresented: $showingSheet) {
                    PermissionsView()
                }
        }
    }

    func checkPermissions() {
        // check status for all three permissions
        let authorized = PermissionsController.canProcceed

        if authorized == false {
            showingSheet.toggle()
        }
    }
}
