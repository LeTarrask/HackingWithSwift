//
//  CardView.swift
//  FlashZilla
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct CardView: View {
    // Property to be used to remove red/green differentiation for color blind people
    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor

    @State private var feedback = UINotificationFeedbackGenerator()

    let card: Card

    var removal: (() -> Void)? = nil

    @State private var isShowingAnswer = false

    @State private var offset = CGSize.zero

    @Environment(\.accessibilityEnabled) var accessibilityEnabled

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(
                    differentiateWithoutColor ? Color.white : Color.white
                        .opacity(1 - Double(abs(offset.width / 50)))
                )
                .opacity(1 - Double(abs(offset.width / 50)))
                .background(differentiateWithoutColor ? nil : RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(offset.width > 0 ? Color.green : Color.red))
                .shadow(radius: 10)

            VStack {
                if accessibilityEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.largeTitle)
                } else {
                    Text(card.prompt)
                        .font(.largeTitle)
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.title)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
            .onTapGesture {
               isShowingAnswer.toggle()
            }
            .animation(.spring())
        }
        .accessibility(addTraits: .isButton)
        .frame(width: 450, height: 250)
        .rotationEffect(.degrees(Double(offset.width / 5)))
        .offset(x: offset.width * 5, y: 0)
        .opacity(2 - Double(abs(offset.width / 50)))
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                    feedback.prepare()
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        if offset.width > 0 {
                            feedback.notificationOccurred(.success)
                        } else {
                            feedback.notificationOccurred(.error)
                        }

                        removal?()
                    } else {
                        offset = .zero
                    }
                }
        )
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CardView(card: Card.example)
                .previewLayout(.fixed(width: 2436 / 3.0, height: 1125 / 3.0))
        }
    }
}
