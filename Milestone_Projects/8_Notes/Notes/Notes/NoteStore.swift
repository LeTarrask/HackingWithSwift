//
//  NoteStore.swift
//  Notes
//
//  Created by Alex Luna on 30/04/2021.
//

import Foundation

class NoteStore: ObservableObject {
    @Published var notes: [Note]

    init() {
        notes = [Note]()

        load()
    }

    func updateNote(note: Note) {
        if let index = getNoteIndex(note: note) {
            notes.remove(at: index)
            notes.insert(note, at: 0)
        } else {
            notes.append(note)
        }
        save()
    }

    func delete(note: Note) {
        if let index = getNoteIndex(note: note) {
            notes.remove(at: index)
        }
        save()
    }

    private func getNoteIndex(note: Note) -> Int? {
        notes.firstIndex(where: { $0.id == note.id })
    }
}

// MARK: - Storage methods
extension NoteStore {
    func load() {
        guard let data = try? Data(contentsOf: Self.notesURL) else { return }

        guard let notes = try? JSONDecoder().decode([Note].self, from: data) else { fatalError("Cannot decode notes")}

        DispatchQueue.main.async {
            self.notes = notes
        }
    }

    func save() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard self?.notes != nil else { fatalError("Self out of scope") }

            guard let data = try? JSONEncoder().encode(self?.notes) else { fatalError("Error encoding data") }

            do {
                let outfile = Self.notesURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write notes to file")
            }
        }
    }

    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory,
                                               in: .userDomainMask,
                                               appropriateFor: nil,
                                               create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }

    private static var notesURL: URL {
        documentsFolder.appendingPathComponent("notes.data")
    }
}



