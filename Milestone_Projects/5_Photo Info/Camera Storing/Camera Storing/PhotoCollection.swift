//
//  PhotoCollection.swift
//  Camera Storing
//
//  Created by Alex Luna on 29/04/2021.
//

import Foundation
import SwiftUI

class PhotoCollection: ObservableObject {
    @Published var photos: [ImageModel] = [ImageModel]()

    func addImage(image: UIImage) {
        guard let data = image.jpegData(compressionQuality: 1) ?? image.pngData() else { return }

        let photo = ImageModel()

        do {
            try data.write(to: PhotoCollection.documentsFolder.appendingPathComponent(photo.imageName))
            print("Saved \(photo.imageName)")

            photos.append(photo)
            saveData()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateDescription(id: UUID, description: String) {
        guard let oldImageIndex = photos.firstIndex(where: {$0.id == id }) else { return }

        var updatedImage = photos[oldImageIndex]
        updatedImage.description = description

        photos.remove(at: oldImageIndex)
        photos.insert(updatedImage, at: oldImageIndex)

        saveData()
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

    private static var photosURL: URL {
        documentsFolder.appendingPathComponent("photos.data")
    }

    func saveData() {
        print("Saving \(photos.count) photos")
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard (self?.photos) != nil else { fatalError("Self out of scope") }
            guard let data = try? JSONEncoder().encode(self?.photos) else { fatalError("Error encoding photo data") }
            do {
                let outfile = Self.photosURL
                try data.write(to: outfile)
            } catch {
                fatalError("Can't write photos to file")
            }
        }
    }

    init() {
        guard let data = try? Data(contentsOf: Self.photosURL) else { return }

        guard let photos = try? JSONDecoder().decode([ImageModel].self, from: data) else {
            fatalError("Can't decode saved refuel data.")
        }
        DispatchQueue.main.async {
            self.photos = photos
        }
    }
}
