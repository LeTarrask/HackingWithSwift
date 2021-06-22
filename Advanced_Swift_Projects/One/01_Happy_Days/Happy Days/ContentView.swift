//
//  ContentView.swift
//  Happy Days
//
//  Created by tarrask on 22/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingSheet = false
    let permissionsVC = PermissionsVC()
    
    var body: some View {
        VStack {
            MemoriesView()
        }
        .onAppear(perform: {
            permissionsVC.checkPermissions()
            if !permissionsVC.authorized {
                showingSheet = true
            }
        })
        .sheet(isPresented: $showingSheet) {
            PermissionsView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
