//
//  View+Bounce.swift
//  
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI
import UIKit

// extension 1: animate out a UIView
extension UIView {
   func bounceOut(duration: TimeInterval) {
in
UIView.animate(withDuration: duration) { [unowned self]
   self.transform = CGAffineTransform(scaleX: 0.0001, y:
0.0001) }
} }

struct bounceOut: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaleEffect(0.0001)
    }
}
