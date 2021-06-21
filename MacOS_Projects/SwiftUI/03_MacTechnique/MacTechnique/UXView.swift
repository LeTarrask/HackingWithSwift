//
//  UXView.swift
//  MacTechnique
//
//  Created by tarrask on 18/06/2021.
//

import SwiftUI

struct UXView: View {
    @State private var isHovering = false
    
    @State private var name = ""
    
    var body: some View {
        VStack {
            
            // HOVER
            Text("Hello, World!")
                .foregroundColor(isHovering ? Color.green : Color.red)
                .padding()
                // hovering action, just like HTML :)
                .onHover { over in
                    self.isHovering = over
                }
            
            // ESCAPE
            TextField("Enter your name", text: $name)
                .onExitCommand {
                    print("Cancel name entry")
                }
            
            // DELETE
            TextField("Enter your name", text: $name)
                .onDeleteCommand {
                    print("Delete pressed")
                }
            
            
        }
        .frame(width: 400, height: .infinity, alignment: .center)
        .padding()
    }
}

struct UXView_Previews: PreviewProvider {
    static var previews: some View {
        UXView()
    }
}
