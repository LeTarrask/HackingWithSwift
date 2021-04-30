//
//  ContentView.swift
//  Notes
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: NoteStore = NoteStore()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(store.notes, id: \.id) { note in
                        NavigationLink(
                            destination: NoteDetailView(store: store, note: note),
                            label: {
                                Text(note.content)
                                    .lineLimit(2)
                            })
                    }
                    .onDelete { offsets in
                        store.notes.remove(atOffsets: offsets)
                    }
                }

                HStack {
                    Spacer()
                    NavigationLink(
                        destination: NoteDetailView(store: store, note: Note() ),
                        label: {
                            Image(systemName: "square.and.pencil")
                                .font(.largeTitle)
                                .foregroundColor(.yellow)
                        })
                }
                .padding()
                
            }
            .navigationTitle("Notes")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
