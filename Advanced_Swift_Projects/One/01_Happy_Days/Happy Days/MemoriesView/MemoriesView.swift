//
//  MemoriesView.swift
//  Happy Days
//
//  Created by tarrask on 22/06/2021.
//

import SwiftUI

struct MemoriesView: View {
    @StateObject var memoriesVC = MemoriesVC()
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    @State private var pressed = false
    @State private var longPressed = false
    @State private var activeMemory: Memory?
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(memoriesVC.memories) { memory in
                        ZStack {
                            Image(uiImage: UIImage(contentsOfFile: memory.imageURL().path)!)
                                .resizable()
                                .scaledToFit()
                                .border(pressed ? Color.red : Color.clear)
                                .onTapGesture(perform: { playAudio(from: memory)
                                })
                                .onLongPressGesture(minimumDuration: 1.0,
                                                    maximumDistance: 200,
                                                    pressing: { pressing in
                                                        pressed = pressing
                                                        // should start recording audio
                                                        activeMemory = memory
                                                        recordMemory()
                                                    },
                                                    perform: {
                                                        finishRecording(success: true)
                                                        
                                                        longPressed = false
                                                    }
                                )
                        }
                    }
                }
            }
            .navigationTitle("Happy Days")
            .navigationBarItems(trailing: Button("Add Image"){
                showingImagePicker = true
            })
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: saveImage) {
            ImagePicker(image: $inputImage) }
    }
    
    private func playAudio(from memory: Memory) {
        memoriesVC.playAudio(from: memory.audioURL())
    }
    
    private func recordMemory() {
        memoriesVC.startRecording()
    }
    
    private func finishRecording(success: Bool) {
        memoriesVC.finishRecording(success: true)
        
        guard let memory = activeMemory else { return }
        memoriesVC.setActiveMemory(memory)
    }
    
    private func saveImage() {
        guard let inputImage = inputImage else { return }
        memoriesVC.addImage(inputImage)
    }
}

struct MemoriesView_Previews: PreviewProvider {
    static var previews: some View {
        MemoriesView()
    }
}
