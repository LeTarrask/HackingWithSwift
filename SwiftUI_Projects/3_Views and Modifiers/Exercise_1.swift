//
//  Exercise_1.swift
//  
//
//  Created by Alex Luna on 10/04/2021.
//

import SwiftUI

struct BlueTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func blueTitleStyle() -> some View {
        self.modifier(BlueTitle())
    }
}

struct Exercise_1_Previews: PreviewProvider {
    static var previews: some View {
        Exercise_1()
    }
}
