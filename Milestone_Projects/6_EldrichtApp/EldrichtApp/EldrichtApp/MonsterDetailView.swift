//
//  MonsterDetailView.swift
//  EldrichtApp
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI

struct MonsterDetailView: View {
    var monster: Monster
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Text("Monster")
                    Text(monster.name)
                    Text(monster.meta)
                }
                
                VStack {
                    Text("Characteristics")
                    HStack {
                        Text(monster.armorClass ?? "")
                        Text(monster.hitPoints ?? "")
                        Text(monster.speed ?? "")
                    }
                }
                
                VStack {
                    Text("Attributes")
                    HStack {
                        Text(monster.STR)
                        Text(monster.DEX)
                        Text(monster.CON)
                        Text(monster.INT)
                        Text(monster.WIS)
                        Text(monster.CHA)
                    }
                }
                
                VStack {
                    Text("Skills")
                    Text(monster.skills ?? "")
                }
                
                VStack {
                    Text("Senses")
                    Text(monster.senses ?? "")
                }
                
                VStack {
                    Text("Languages")
                    Text(monster.languages ?? "")
                }
                
                VStack {
                    Text("Challenge")
                    Text(monster.challenge ?? "")
                }
                
                VStack {
                    Text("Traits")
                    Text(monster.traits ?? "")
                }
                
                VStack {
                    Text("Actions")
                    Text(monster.actions ?? "")
                }
                
                VStack {
                    Text("Legendary Actions")
                    Text(monster.legendaryActions ?? "")
                }
            }
        }
    }
}
