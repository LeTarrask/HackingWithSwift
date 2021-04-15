//
//  ContentView5_Disappear.swift
//  Animations
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct ContentView5_Disappear: View {
    @State private var isShowingRed = false
    var body: some View {
        VStack {
            Button("Tap Me") {
                withAnimation {
                   self.isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
            }
        }
    }
}

struct ContentView5_Disappear_Previews: PreviewProvider {
    static var previews: some View {
        ContentView5_Disappear()
    }
}
