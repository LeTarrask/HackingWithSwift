//
//  MonsterModel.swift
//  EldrichtApp
//
//  Created by Alex Luna on 30/04/2021.
//

import Foundation

struct Monster: Codable {
    let name: String
    let meta: String
    let armorClass: String?
    let hitPoints: String?
    let speed: String?
    let STR: String
    let STRmod: String?
    let DEX: String
    let DEXmod: String?
    let CON: String
    let CONmod: String?
    let INT: String
    let INTmod: String?
    let WIS: String
    let WISmod: String?
    let CHA: String
    let CHAmod: String?
    let skills: String?
    let savingThrows: String?
    let senses: String?
    let languages: String?
    let challenge: String?
    let traits: String?
    let actions: String?
    let legendaryActions: String?
    let imgUrl: URL?

    enum CodingKeys: String, CodingKey {
        case name
        case meta
        case armorClass = "Armor Class"
        case hitPoints = "Hit Points"
        case speed = "Speed"
        case STR
        case STRmod = "STR_mod"
        case DEX
        case DEXmod = "DEX_mod"
        case CON
        case CONmod = "CON_mod"
        case INT
        case INTmod = "INT_mod"
        case WIS
        case WISmod = "WIS_mod"
        case CHA
        case CHAmod = "CHA_mod"
        case skills = "Skills"
        case savingThrows = "Saving Throws"
        case senses = "Senses"
        case languages = "Languages"
        case challenge = "Challenge"
        case traits = "Traits"
        case actions = "Actions"
        case legendaryActions = "Legendary Actions"
        case imgUrl = "img_url"
    }
}

extension Monster: Identifiable {
    var id: String { name }
}
