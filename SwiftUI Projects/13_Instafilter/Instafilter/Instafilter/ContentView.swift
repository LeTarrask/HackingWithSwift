//
//  ContentView.swift
//  Instafilter
//
//  Created by Alex Luna on 13/04/2021.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5

    @State private var showingImagePicker = false

    @State private var inputImage: UIImage?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()

    @State private var showingFilterSheet = false

    @State private var processedImage: UIImage?

    @State private var showingAlert = false

    var body: some View {
        let intensity = Binding<Double>(
            get: {
                self.filterIntensity
            },
            set: {
                self.filterIntensity = $0
                self.applyProcessing()
            } )
        return NavigationView {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(Color.secondary)
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    } else {
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                    }
                }
                .onTapGesture {
                    showingImagePicker = true
                }
                HStack {
                    Text("Intensity")
                    Slider(value: intensity)
                }.padding(.vertical)
                HStack {
                    Button(currentFilter.name) {
                        showingFilterSheet = true
                    }
                    Spacer()
                    Button("Save") {
                        guard image != nil else {
                            showingAlert = true
                            return
                        }
                        guard let processedImage = processedImage else { return }
                        let imageSaver = ImageSaver()
                        imageSaver.successHandler = {
                            print("Success!")
                        }
                        imageSaver.errorHandler = {
                            print("Oops: \($0.localizedDescription)")
                        }
                        imageSaver.writeToPhotoAlbum(image: processedImage)
                    }
                }
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: $inputImage) }
            .actionSheet(isPresented: $showingFilterSheet) {
                ActionSheet(title: Text("Select a filter"), buttons: [
                                .default(Text("Crystallize"))
                                    { setFilter(CIFilter.crystallize()) },
                                .default(Text("Edges"))
                                    { setFilter(CIFilter.edges()) },
                                .default(Text("Gaussian Blur"))
                                    { setFilter(CIFilter.gaussianBlur()) },
                                .default(Text("Pixellate"))
                                    { setFilter(CIFilter.pixellate()) },
                                .default(Text("Sepia Tone"))
                                    { setFilter(CIFilter.sepiaTone()) },
                                .default(Text("Unsharp Mask"))
                                    { setFilter(CIFilter.unsharpMask()) },
                                .default(Text("Vignette"))
                                    { setFilter(CIFilter.vignette()) },
                                .cancel() ])
            }
            .alert(isPresented: $showingAlert) {
                        Alert(title: Text("No image selected"), message: Text("Pick an image and edit it first"), dismissButton: .default(Text("Cool!")))
                    }
            .padding([.horizontal, .bottom])
            .navigationBarTitle("Instafilter")
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func applyProcessing() {
        // these are values that can be adjusted for all Core Image Filters
        let inputKeys = currentFilter.inputKeys
        if inputKeys.contains(kCIInputIntensityKey) { currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey) }
        if inputKeys.contains(kCIInputRadiusKey) { currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)}
        if inputKeys.contains(kCIInputScaleKey) { currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey) }

        guard let outputImage = currentFilter.outputImage else { return }
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }

    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
