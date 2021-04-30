//
//  Array+remove-Extension.swift
//  
//
//  Created by Alex Luna on 30/04/2021.
//

import Foundation

extension Array where Element: Comparable {
    mutating func remove(item: Element) {
        if let location =  self.firstIndex(of: item) {
            self.remove(at: location)
        }
    }
}
