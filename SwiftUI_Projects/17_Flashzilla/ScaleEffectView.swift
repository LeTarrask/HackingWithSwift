//
//  ScaleEffectView.swift
//  
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct ScaleEffectView: View {
    @State private var currentAmount: CGFloat = 0
    @State private var finalAmount: CGFloat = 1

    var body: some View {
        Text("Hello, World!")
            .scaleEffect(finalAmount + currentAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { amount in
                        currentAmount = amount - 1
                    }
                    .onEnded { amount in
                        currentAmount
                        currentAmount = 0
                    } )
    }
}

struct ScaleEffectView_Previews: PreviewProvider {
    static var previews: some View {
        ScaleEffectView()
    }
}
