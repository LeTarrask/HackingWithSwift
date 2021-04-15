//
//  Astronaut.swift
//  Moonshots
//
//  Created by Alex Luna on 12/04/2021.
//

import Foundation

struct Astronaut: Codable, Identifiable {
   let id: String
   let name: String
   let description: String
}

//init(astronaut: Astronaut) {
//    self.astronaut = astronaut
//
//    let missions: [Mission] = Bundle.main.decode("missions.json")
//
//    print("astronaut id " + astronaut.id)
//    var matches = [String]()
//    for mission in missions {
//        for member in mission.crew {
//            if astronaut.id == member.name {
//                print("mission name " + mission.displayName)
//                matches.append(mission.displayName)
//            }
//        }
//    }
//
//    print(matches)
//    missionString = matches.joined(separator: "-")
//    print(missionString)
//}
