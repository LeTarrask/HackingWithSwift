//
//  NoteDetailView.swift
//  Notes
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI

struct NoteDetailView: View {
    @Environment(\.presentationMode) var presentation

    @ObservedObject var store: NoteStore

    @State var note: Note

    @State private var isSharePresented: Bool = false

    var body: some View {
        VStack {
            VStack {
                Text(note.date, style: .date)
                    .font(.caption)
                    .frame(maxHeight: 30)
                TextEditor(text: $note.content)
                    .lineLimit(0)
                    .padding()
                Spacer()
            }.navigationBarItems(trailing:
                                    HStack {
                                        Button(action: {
                                            delete()
                                            presentation.wrappedValue.dismiss()
                                        }, label: { Image(systemName: "trash") })
                                        Button(action: { isSharePresented = true }, label: {
                                            Image(systemName: "square.and.arrow.up")
                                        })
                                        Button(action: { save() }, label: { Text("OK")  })
                                    }.foregroundColor(.yellow)
            )
        }
        .sheet(isPresented: $isSharePresented, onDismiss: {
                    print("Dismiss")
                }, content: {
                    ActivityViewController(activityItems: [note.content])
                })
    }

    private func delete() {
        store.delete(note: note)
    }

    private func save() {
        let newNote = note
        print(newNote.content)
        store.updateNote(note: newNote)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        var note = Note()
        note.content = "loerm oihasdfkuhadf kjasdhf lasdjf asldjf aslkdfj salkdfj "
        return NoteDetailView(store: NoteStore(), note: note)
    }
}
