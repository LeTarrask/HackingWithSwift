//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Alex Luna on 09/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()

    // Added these labels for accessibility
    let labels = [
        "Estonia": "Flag with three horizontal stripes of equal size. Top stripe blue, middle stripe black, bottom stripe white",
        "France": "Flag with three vertical stripes of equal size. Left stripe blue, middle stripe white, right stripe red",
        "Germany": "Flag with three horizontal stripes of equal size. Top stripe black, middle stripe red, bottom stripe gold",
        "Ireland": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe orange",
        "Italy": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe red",
        "Nigeria": "Flag with three vertical stripes of equal size. Left stripe green, middle stripe white, right stripe green",
        "Poland": "Flag with two horizontal stripes of equal size. Top stripe white, bottom stripe red",
        "Russia": "Flag with three horizontal stripes of equal size. Top stripe white, middle stripe blue, bottom stripe red",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background",
        "US": "Flag with red and white stripes of equal size, with white stars on a blue background in the top-left corner"
     ]

    @State private var correctAnswer = Int.random(in: 0...2)

    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var rightAnswer = false
    @State private var wrongAnswer = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]),
                           startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)

            if wrongAnswer {
                Rectangle()
                    .fill(Color.red)
                    .edgesIgnoringSafeArea(.all)
            }

            VStack {
                Text("Tap the flag of")
                Text(countries[correctAnswer])
                    .font(.largeTitle)
                    .fontWeight(.black)
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(countries[number])
                            .flagStyle()
                            .rotation3DEffect(.degrees(rightAnswer && number == correctAnswer ? 0 : 360), axis: (x: 0, y: 1, z: 0))
                            .opacity(rightAnswer && number != correctAnswer ? 0.25 : 1)
                            .animation(.easeInOut(duration: 1.0))
                            .accessibility(label: Text(labels[countries[number],
                            default: "Unknown flag"]))

                    }
                }
                Text("Current score: \(score)")

                Spacer()
            }
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle),
                      message: Text("Your score is \(score)"),
                      dismissButton: .default(Text("Continue")) {
                        askQuestion()
                      })
            }
            .foregroundColor(.white)
            
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            withAnimation {
                rightAnswer = true
            }
        } else {
            scoreTitle = "Wrong, you picked the flag of \(countries[number])"
            score -= 1
            withAnimation {
                wrongAnswer = true
            }
        }
        showingScore = true
    }

    func askQuestion() {
        rightAnswer = false
        wrongAnswer = false
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .clipShape(Capsule())
            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
            .shadow(color: Color.black, radius: 2)
    }
}

extension View {
    func flagStyle() -> some View {
        self.modifier(FlagImage())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
