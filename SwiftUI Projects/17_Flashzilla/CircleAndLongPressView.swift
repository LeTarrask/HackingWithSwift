//
//  CircleAndLongPressView.swift
//  
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct CircleAndLongPressView: View {
    // how far the circle has been dragged
    @State private var offset = CGSize.zero

    // where it is currently being dragged or not
    @State private var isDragging = false

    var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in offset = value.translation }
            .onEnded { _ in
                withAnimation {
                    offset = .zero
                    isDragging = false
                }
            }

        // a long press gesture that enables isDragging
        let tapGesture = LongPressGesture()
            .onEnded { value in
                withAnimation {
                    isDragging = true
                } }
        // a combined gesture that forces the user to long press then drag

        let combined = tapGesture.sequenced(before: dragGesture)
        // a 64x64 circle that scales up when it's dragged, sets its offset to whatever we had back from the drag gesture, and uses our combined gesture
        return Circle()
            .fill(Color.red)
            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(offset)
            .gesture(combined)
    }
}

struct CircleAndLongPressView_Previews: PreviewProvider {
    static var previews: some View {
        CircleAndLongPressView()
    }
}
