//
//  Move.swift
//  Four in a row
//
//  Created by Alex Luna on 07/05/2021.
//

import GameplayKit
import UIKit

class Move: NSObject, GKGameModelUpdate {
    var value: Int = 0
    var column: Int
    init(column: Int) {
        self.column = column
    }
}
