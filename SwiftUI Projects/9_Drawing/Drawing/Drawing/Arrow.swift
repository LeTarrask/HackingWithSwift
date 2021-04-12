//
//  Arrow.swift
//  Drawing
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct Arrow: View {
    var body: some View {
        VStack {
            Triangle()
                .stroke(Color.blue, lineWidth: 10)
                .padding(.bottom, -8)

            Rectangle()
                .stroke(Color.blue, lineWidth: 10)
                .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
        }
    }
}

struct Arrow_Previews: PreviewProvider {
    static var previews: some View {
        Arrow()
    }
}
