//
//  ContentView2-Snake.swift
//  Animations
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct ContentView2_Snake: View {
    @State private var dragAmount = CGSize.zero
    let letters = Array("Hello SwiftUI")
    @State private var enabled = false

    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<letters.count) { num in
                Text(String(self.letters[num]))
                    .padding(5)
                    .font(.title)
                    .background(self.enabled ? Color.blue : Color.red)
                    .offset(self.dragAmount)
                    .animation(Animation.default.delay(Double(num) / 20))
            }}
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        self.dragAmount = .zero
                        self.enabled.toggle()
                    })

    }
}


struct ContentView2_Snake_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2_Snake()
    }
}
