//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Alex Luna on 15/04/2021.
//

import SwiftUI

class Favorites: ObservableObject {
    // the actual resorts the user has favorited
    private var resorts: Set<String>

    // the key we're using to read/write in UserDefaults
    private let saveKey = "Favorites"

    init() {


        // Use an empty array
        resorts = []

        // load our saved data
        let filename = getDocumentsDirectory().appendingPathComponent("SavedFavorites")
        do {
            let data = try Data(contentsOf: filename)
            let decoded = try JSONDecoder().decode([Resort].self, from: data)
            for resort in decoded {
                add(resort)
            }
        } catch {
            print("Unable to load saved data.")
        }
    }

    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    // returns true if our set contains this resort
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    // adds the resort to our set, updates all views, and saves the change
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    // removes the resort from our set, updates all views, and saves the change
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    func save() {
        do {
            let filename =
                getDocumentsDirectory().appendingPathComponent("SavedFavorites")
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save data.")
        }
    }
}
