//
//  ContentView.swift
//  Meme Generator
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var showingImagePicker = false

    @State private var inputImage: UIImage?

    @State var superText: String = ""

    @State var lowerText: String = ""

    @State private var isSharePresented: Bool = false

    @State var exportingImage: UIImage?

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: {
                    generateImage()
                    isSharePresented = true
                },
                       label: { Image(systemName: "square.and.arrow.up")  })
                .padding()
            }

            HStack {
                TextField("super text", text: $superText)
                Spacer()
                TextField("lower text", text: $lowerText)
            }
            Group {
                if (inputImage == nil) {
                    Button(action: { showingImagePicker = true }, label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 15)
                                .foregroundColor(.gray)
                            Image(systemName: "camera")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                        }
                        .frame(width: 100, height: 100)
                    })
                } else {
                    memeView
                }
            }
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: {} ) {
            ImagePicker(image: $inputImage)
        }
    }

    private func generateImage() {
        exportingImage = memeView.snapshot()
    }

    var memeView: some View {
        ZStack {
            Image(uiImage: inputImage!)
                .resizable()
                .scaledToFill()

            VStack {
                Text(superText)
                    .fontWeight(.black)
                Spacer()
                Text(lowerText)
                    .fontWeight(.black)
            }
            .foregroundColor(.white)
            .font(Font.custom("Impact", size: 48.0, relativeTo: .headline))
        }
        .sheet(isPresented: $isSharePresented,
               onDismiss: { print("Dismiss") },
               content: {
//                let jpgImage = exportingImage?.jpegData(compressionQuality: 0.8)
                ActivityViewController(activityItems: [exportingImage])
                })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(superText: "", lowerText: "")
    }
}


