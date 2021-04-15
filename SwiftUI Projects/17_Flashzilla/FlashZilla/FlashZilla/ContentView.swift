//
//  ContentView.swift
//  FlashZilla
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var cards = [Card]()

    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    @State private var timeRemaining = 100
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    @State private var isActive = true

    @State private var showingEditScreen = false

    @State private var timeIsUpAlertPresented = false

    @State var reshuffleWrong: Bool = false
    @State private var showingSettingsView = false

    var body: some View {
        ZStack {
            Image(decorative: "background")
               .resizable()
               .scaledToFill()
               .edgesIgnoringSafeArea(.all)

            Text("Time: \(timeRemaining)")
               .font(.largeTitle)
               .foregroundColor(.white)
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
                .background(
                    Capsule()
                        .fill(Color.black)
                        .opacity(0.75)
                )
            
            VStack {
                ZStack {
                    ForEach(0..<cards.count, id: \.self) { index in
                        CardView(card: cards[index]) {
                            withAnimation {
                                if reshuffleWrong {
                                    // should also check if answer is right or wrong
                                } else {
                                    removeCard(at: index)
                                }
                            }
                        }
                        .stacked(at: index, in: cards.count)
                        .allowsHitTesting(index == cards.count - 1) // only allows touch for the top card
                        .accessibility(hidden: index < self.cards.count - 1) // hides the cards that are not in front in accessibility
                    }
                }
                .allowsHitTesting(timeRemaining > 0)

                if cards.isEmpty {
                    Button("Start Again", action: resetCards)
                        .padding()
                        .background(Color.white)
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                }
            }

            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Button(action: {
                            showingEditScreen = true
                        }) {
                            Image(systemName: "plus.circle")
                        }.sheet(isPresented: $showingEditScreen, onDismiss: resetCards) { EditCards() }
                        Spacer()
                        Button(action: {}) {
                            Image(systemName: "gear")
                        }.sheet(isPresented: $showingSettingsView) {
                            SettingsScreen(recoverWrong: $reshuffleWrong)
                        }
                    }.frame(height: 100)
                }
                Spacer()
            }
            .foregroundColor(.white)
            .font(.largeTitle)
            .padding()

            if differentiateWithoutColor || accessibilityEnabled {
                VStack {
                    Spacer()
                    HStack {
                        Button(action: {
                                withAnimation {
                                    removeCard(at: self.cards.count - 1)
                                } }) {
                            Image(systemName: "xmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Wrong"))
                        .accessibility(hint: Text("Mark your answer as being incorrect."))
                        Spacer()
                        Button(action: {
                            withAnimation {
                                self.removeCard(at: self.cards.count - 1)
                            }
                        }) {
                            Image(systemName: "checkmark.circle")
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .clipShape(Circle())
                        }
                        .accessibility(label: Text("Correct"))
                        .accessibility(hint: Text("Mark your answer as being correct."))
                    }
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .padding()
                }
            }
        }

        .onAppear(perform: resetCards)
        .onReceive(timer) { time in
            guard self.isActive else { return }
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else if timeRemaining == 0 {
                timeIsUpAlertPresented = true
            }
        }
        .alert(isPresented: $timeIsUpAlertPresented) {
            Alert(title: Text("Time is up"),
                  primaryButton: .default(Text("Restart"), action: {
                    resetCards()
                  }),
                  secondaryButton: .cancel())
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            isActive = false
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            if cards.isEmpty == false {
                isActive = true
            }
        }
    }

    func removeCard(at index: Int) {
        guard index >= 0 else { return }
        cards.remove(at: index)
        if cards.isEmpty {
            isActive = false
        }
    }

    func resetCards() {
        timeRemaining = 100
        isActive = true
        loadData()
    }

    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                self.cards = decoded
            }
        }
    }
}

extension View {
    func stacked(at position: Int, in total: Int) -> some View {
        let offset = CGFloat(total - position)
        return self.offset(CGSize(width: 0, height: offset * 10))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
    }
}
