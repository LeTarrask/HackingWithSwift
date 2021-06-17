//
//  MemoriesView.swift
//  Happy Days
//
//  Created by Alex Luna on 16/06/2021.
//

import SwiftUI
import AVFoundation
import Photos
import Speech

struct MemoryCollection: View {
    @StateObject var memVC = MemoriesController()

    @State private var showingImagePicker = false

    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(memVC.memories) { memory in
                    MemoryView(memory)
                }
            }
                .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: $inputImage) }
                .navigationBarItems(trailing: Button("Pick Image") { showingImagePicker.toggle() })
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        memVC.saveNewMemory(image: inputImage)
    }
}



struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryCollection()
    }
}
