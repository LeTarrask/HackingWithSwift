//
//  GameController.swift
//  Hangman
//
//  Created by Alex Luna on 28/04/2021.
//

import Foundation

class GameController: ObservableObject {
    private var allWords = [String]()

    @Published var currentWord: String = ""

    init () {
        DispatchQueue.global().async {
            if let wordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
                if let words = try? String(contentsOf: wordsURL) {
                    self.allWords = words.components(separatedBy: "\n")
                    self.getNewWord()
                }
            }
        }
    }

    func getNewWord() {
        currentWord = allWords.randomElement() ?? ""
    }
}
