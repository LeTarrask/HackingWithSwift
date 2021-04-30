//
//  ContentView.swift
//  Camera Storing
//
//  Created by Alex Luna on 28/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false

    @State private var inputImage: UIImage?

    @ObservedObject var collection = PhotoCollection()

    let columns: [GridItem] = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            Button(action: { showingImagePicker = true },
                   label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 15)
                            .foregroundColor(.gray)
                        Image(systemName: "camera")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    .frame(width: 100, height: 100)
                   })
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(collection.photos, id: \.id) { photo in
                        IconView(collection: collection, photo: photo)
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: addImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func addImage() {
        // TO DO: To make this code usable, maybe reduce image size??
        // Template images from XCode are HYUGE
        guard let inputImage = inputImage else { return }

        collection.addImage(image: inputImage)
    }
}

struct IconView: View {
    @ObservedObject var collection: PhotoCollection

    var photo: ImageModel

    @State var textDescription: String = ""

    var body: some View {
        VStack {
            photo.imageView?
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            TextField("Description", text: $textDescription)
            Button("Save") {
                updateDescription()
            }
        }.onAppear( perform: loadDescription )
    }

    func loadDescription() {
        if photo.description != "" {
            textDescription = photo.description
        }
    }

    func updateDescription() {
        collection.updateDescription(id: photo.id, description: textDescription)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

