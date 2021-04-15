//
//  HapticsGenerators.swift
//  
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct HapticsGenerators: View {
    var body: some View {
        Text("Hello, World!")
            .onTapGesture(perform: simpleSuccess)
    }

    func simpleSuccess() {
       let generator = UINotificationFeedbackGenerator()
       generator.notificationOccurred(.success)
    }
}

struct HapticsGenerators_Previews: PreviewProvider {
    static var previews: some View {
        HapticsGenerators()
    }
}
