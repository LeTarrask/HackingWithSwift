//
//  insettable shape.swift
//  Drawing
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct insettable_shape: View {
    var body: some View {
        Circle()
            .strokeBorder(Color.blue, lineWidth: 40)
    }
}

struct insettable_shape_Previews: PreviewProvider {
    static var previews: some View {
        insettable_shape()
    }
}
