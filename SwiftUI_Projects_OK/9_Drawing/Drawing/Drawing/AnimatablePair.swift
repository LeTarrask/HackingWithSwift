//
//  AnimatablePair.swift
//  Drawing
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct AnimatablePair: View {
    @State private var rows = 4
    @State private var columns = 4

    var body: some View {
        Checkerboard(rows: rows, columns: columns)
            .onTapGesture {
                withAnimation(.linear(duration: 3)) {
                    rows = 8
                    columns = 16
                }
            }
    }
}

struct Checkerboard: Shape {
//    public var animatableData: AnimatablePair {
//        get {
//            AnimatablePair(Double(rows), Double(columns))
//        }
//        set {
//            rows = Int(newValue.first)
//            columns = Int(newValue.second)
//        }
//    }

    // THIS TUTORIAL IS NOT WORKING FOR SOME REASON

    var rows: Int
    var columns: Int

    func path(in rect: CGRect) -> Path {
        var path = Path()
        // figure out how big each row/column needs to be
        let rowSize = rect.height / CGFloat(rows)
        let columnSize = rect.width / CGFloat(columns)
        // loop over all rows and columns, making alternating
        // squares colored
        for row in 0..<rows {
            for column in 0..<columns {
                if (row + column).isMultiple(of: 2) {
                    // this square should be colored; add a
                    // rectangle here
                    let startX = columnSize * CGFloat(column)
                    let startY = rowSize * CGFloat(row)
                    let rect = CGRect(x: startX, y: startY, width:
                                        columnSize, height: rowSize)
                    path.addRect(rect)
                }
            }
        }
        return path
    }
}

struct AnimatablePair_Previews: PreviewProvider {
    static var previews: some View {
        AnimatablePair()
    }
}
