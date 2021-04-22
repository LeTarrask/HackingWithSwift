//
//  Petition.swift
//  Whitehouse petitions
//
//  Created by Alex Luna on 22/04/2021.
//

import Foundation

struct Petition: Codable {
    var title: String
    var body: String
    var signatureCount: Int
}

struct Petitions: Codable {
    var results: [Petition]
}
