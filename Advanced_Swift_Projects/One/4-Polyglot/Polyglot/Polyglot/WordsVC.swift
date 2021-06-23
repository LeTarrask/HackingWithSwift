//
//  WordsVC.swift
//  Polyglot
//
//  Created by tarrask on 23/06/2021.
//

import Foundation

class WordsViewController: ObservableObject {
    @Published var words = [String]()
    
    init() {
        let defaults = UserDefaults.standard
        if let savedWords = defaults.object(forKey: "Words") as? [String] {
            words = savedWords
        } else {
            saveInitialValues(to: defaults)
        }
    }
    
    func insertWords(first: String, second: String) {
        guard first.count > 0 && second.count > 0 else { return }
                
        words.append("\(first)::\(second)")
        
        saveWords()
    }

    
    func remove(at indexSet: IndexSet) {
        words.remove(atOffsets: indexSet)
        saveWords()
    }
    
    func saveWords() {
        let defaults = UserDefaults.standard
        defaults.set(words, forKey: "Words")
    }
    
    func saveInitialValues(to defaults: UserDefaults) {
       words.append("bear::l'ours")
       words.append("camel::le chameau")
       words.append("cow::la vache")
       words.append("fox::le renard")
       words.append("goat::la chèvre")
       words.append("monkey::le singe")
       words.append("pig::le cochon")
       words.append("rabbit::le lapin")
       words.append("sheep::le mouton")
       defaults.set(words, forKey: "Words")
    }
}
