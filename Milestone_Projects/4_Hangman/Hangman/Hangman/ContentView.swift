//
//  ContentView.swift
//  Hangman
//
//  Created by Alex Luna on 28/04/2021.
//

import SwiftUI

struct ContentView: View {
    let gameController = GameController()

    var body: some View {
        HStack {
//            ForEach(Array(gameController.currentWord.enumerated()),
//                    id: \.self) { position, letter in
//                Text(letter.description)
////                ButtonView(letter: letter, position: position)
//            }

            ForEach(Range(1...7)) { position in
                ButtonView(letter: "A", position: position)
            }
        }
    }
}

struct ButtonView {
    var letter: Character
    var position: Int
    var isHidden: Bool = true

    var body: some View {
        Button(letter.description) {
            print(position)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
