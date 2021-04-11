//
//  ViewModifier.swift
//  
//
//  Created by Alex Luna on 09/04/2021.
//

import SwiftUI

struct ViewModifier: View {
    var body: some View {
        VStack {
            Text("Hello World")
                .modifier(Title())
            Text("Hello World")
                .titleStyle()
        }
    }
}

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

extension View {
    func titleStyle() -> some View {
        self.modifier(Title())
    }
}


struct ViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifier()
    }
}
