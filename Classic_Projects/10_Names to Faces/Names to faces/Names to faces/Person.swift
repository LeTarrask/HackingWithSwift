//
//  Person.swift
//  Names to faces
//
//  Created by Alex Luna on 23/04/2021.
//

import UIKit

class Person: NSObject {
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }
}
