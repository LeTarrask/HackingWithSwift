//
//  Int+Times-Extension.swift
//  
//
//  Created by Alex Luna on 30/04/2021.
//

import Foundation

extension Int {
    func times(_ closure: () -> Void ) {
        guard self > 0 else { return }
        for _ in range 0..< self {
            closure()
        }
    }
}
