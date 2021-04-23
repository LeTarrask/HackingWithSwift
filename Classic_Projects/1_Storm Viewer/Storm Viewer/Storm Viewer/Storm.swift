//
//  Storm.swift
//  Storm Viewer
//
//  Created by Alex Luna on 23/04/2021.
//

import Foundation


struct Storm: Codable, Comparable {
    static func < (lhs: Storm, rhs: Storm) -> Bool {
        lhs.image > rhs.image
    }

    let image: String
    var timesShown: Int
}
