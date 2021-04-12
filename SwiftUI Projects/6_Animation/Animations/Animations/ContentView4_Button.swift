//
//  ContentView4_Button.swift
//  Animations
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct ContentView4_Button: View {
    @State private var animationAmount = 0.0

    @State private var enabled = false

    var body: some View {
        VStack {
            Stepper("Scale amount", value:
                        $animationAmount.animation(), in: 1...10)
            Spacer()
            Button("Tap Me") {
               self.enabled.toggle()
            }
            .frame(width: 200, height: 200)
            .background(enabled ? Color.blue : Color.red)
            .animation(nil)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
            .animation(.interpolatingSpring(stiffness: 10, damping: 1))
        }
    }
}

struct ContentView4_Button_Previews: PreviewProvider {
    static var previews: some View {
        ContentView4_Button()
    }
}
