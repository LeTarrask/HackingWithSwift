//
//  ContentView.swift
//  Polyglot
//
//  Created by tarrask on 23/06/2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var wordsVC = WordsViewController()
    
    @State var isTapped: Bool = false
    
    @State private var isAdding = false
    @State private var englishWord = ""
    @State private var frenchWord = ""
      
    var body: some View {
        NavigationView {
            VStack {
                addView()
                
                List {
                    ForEach(wordsVC.words, id: \.self) { word in
                        let split = word.components(separatedBy: "::")
                        Text(!isTapped ? split[0] : split[1])
                    }
                    .onDelete(perform: { indexSet in
                        wordsVC.remove(at: indexSet)
                    })
                    .onTapGesture {
                        isTapped.toggle()
                    }
                }
                .navigationTitle("Polyglot")
            }
        }
    }
    
    @ViewBuilder
    func addView() -> some View {
        switch isAdding {
        case true:
            Group {
                TextField("English word", text: $englishWord)
                TextField("French word", text: $frenchWord)
                Button("Add word"){
                    wordsVC.insertWords(first: englishWord, second: frenchWord)
                    isAdding = false
                }
            }
        case false:
            Button("Add word") {
                isAdding = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
