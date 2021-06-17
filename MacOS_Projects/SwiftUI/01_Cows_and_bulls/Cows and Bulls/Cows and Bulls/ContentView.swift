//
//  ContentView.swift
//  Cows and Bulls
//
//  Created by Alex Luna on 17/06/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var guesses = [String]()

    @State private var guess = ""

    @State private var answer = ""

    @State private var isGameOver = false

    var body: some View {
        VStack(spacing: 0) {
            HStack {
                TextField("Enter a guess...", text: $guess, onCommit: submitGuess)
                Button("Go", action: submitGuess)
            }
            .padding()

            List(guesses, id: \.self) { guess in
                Text(guess)
                Spacer()
                Text(result(for: guess))
            }
            .listStyle(SidebarListStyle())
        }
        .frame(width: 250)
        .frame(minHeight: 300)
        .onAppear(perform: startNewGame)
        .alert(isPresented: $isGameOver) {
            Alert(title: Text("You win"), message: Text("Congratulations! You made \(guesses.count) moves. Try to beat it next time. Click OK to play again."), dismissButton: .default(Text("OK"), action: startNewGame))
        }
        .touchBar {
           Text("Guesses: \(guesses.count)")
              .font(.title)
              .touchBarItemPrincipal()
           Spacer(minLength: 200)
        }
    }

    func submitGuess() {
        let badCharacters = CharacterSet(charactersIn: "0123456789").inverted
        guard guess.rangeOfCharacter(from: badCharacters) == nil else { return }

        withAnimation {
           guesses.insert(guess, at: 0)
        }

        // did the player win?
        if result(for: guess).contains("4b") {
            isGameOver = true
        }

        // clear their guess string
        guess = ""
    }

    func result(for guess: String) -> String {
        var bulls = 0
        var cows = 0

        let guessLetters = Array(guess)
        let answerLetters = Array(answer)

        for (index, letter) in guessLetters.enumerated() {
            if letter == answerLetters[index] {
                bulls += 1
            } else if answerLetters.contains(letter) {
                cows += 1 }
        }
        return "\(bulls)b \(cows)c"
    }

    func startNewGame() {
        guesses.removeAll()
        answer = ""
        var numbers = Array(0...9)
        numbers.shuffle()

        for i in 0 ..< 4 {
            answer.append(String(numbers[i]))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
