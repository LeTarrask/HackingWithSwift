//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Alex Luna on 14/04/2021.
//

import Foundation

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]

    static let saveKey = "SavedData"
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
    
    init() {
        people = []
        let filename = getDocumentsDirectory().appendingPathComponent("SavedProspects")
        do {
            let data = try Data(contentsOf: filename)
            people = try JSONDecoder().decode([Prospect].self, from: data)
        } catch {
            print("Unable to load saved data.")
        }

        // this is deprecated saving in user defaults code
//        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }

    }

    // MARK: - File Storage with encryption
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }

    private func save() {
        // this is userdefaults saving code that was deprecated in the challenge
//       if let encoded = try? JSONEncoder().encode(people) {
//        UserDefaults.standard.set(encoded, forKey: Self.saveKey)
//       }

        // this is the JSON saving to documents directory per project challenge
        do {
            let filename =
                getDocumentsDirectory().appendingPathComponent("SavedProspects")
            let data = try JSONEncoder().encode(people)
            try data.write(to: filename, options: [.atomicWrite])
        } catch {
            print("Unable to save data.")
        }
    }

    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
}
