//
//  ContentView.swift
//  EldrichtApp
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manual = MonsterManual()

    var body: some View {
        NavigationView {
            List {
                ForEach(manual.monsters) { monster in
                    NavigationLink(destination: MonsterDetailView(monster: monster)) {
                        Text(monster.name)
                    }
                }
            }
            .navigationTitle("Monster Manual")
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
