//
//  ContentView3_Card.swift
//  Animations
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct ContentView3_Card: View {
    @State private var dragAmount = CGSize.zero

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.yellow, .red]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .frame(width: 300, height: 200)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .animation(.spring())
            .offset(dragAmount)
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.spring()) {
                            self.dragAmount = .zero
                        }
                    }
            )
    }
}

struct ContentView3_Card_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3_Card()
    }
}
