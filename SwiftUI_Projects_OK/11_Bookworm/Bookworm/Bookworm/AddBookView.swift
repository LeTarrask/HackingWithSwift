//
//  AddBookView.swift
//  Bookworm
//
//  Created by Alex Luna on 13/04/2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc

    @Environment(\.presentationMode) var presentationMode

    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "No genre"
    @State private var review = ""

    let genres = ["No genre", "Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0) }
                    } }
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                Section {
                    Button("Save") {
                        let newBook = Book(context: moc)
                        newBook.title = title
                        newBook.author = author
                        newBook.rating = Int16(rating)
                        newBook.genre = genre
                        newBook.review = review
                        newBook.date = Date()
                        try? moc.save()

                        presentationMode.wrappedValue.dismiss()
                    } }
            }
            .navigationBarTitle("Add Book")
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}