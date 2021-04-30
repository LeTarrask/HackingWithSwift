//
//  MonsterManual.swift
//  EldrichtApp
//
//  Created by Alex Luna on 30/04/2021.
//

import Foundation

class MonsterManual: ObservableObject {
    private let storageFileName: String = "srd_5e_monsters.json"

    @Published var monsters = [Monster]()

    init() {
        getDecoded()
    }

    func getDecoded() {
        monsters = Bundle.main.decode([Monster].self, from: storageFileName)
    }
}

