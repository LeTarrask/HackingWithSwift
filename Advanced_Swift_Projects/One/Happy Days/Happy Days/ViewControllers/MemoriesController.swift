//
//  MemoriesController.swift
//  Happy Days
//
//  Created by Alex Luna on 16/06/2021.
//

import Foundation
import UIKit

struct Memory: Identifiable {
    let id = UUID()
    var thumbURL: URL
    var imageURL: URL
    var name: String


}

class MemoriesController: ObservableObject {
    @Published var memories = [Memory]()

    func record() {

    }

    func stopRecord() {

    }

    func loadMemories() {
        memories.removeAll()
        // attempt to load all the memories in our documents directory
        guard let files = try? FileManager.default.contentsOfDirectory(at: getDocumentsDirectory(), includingPropertiesForKeys: nil, options: []) else { return }

        // loop over every file found
        for file in files {
            let filename = file.lastPathComponent
            // check it ends with ".thumb" so we don't count each memory more than once
            if filename.hasSuffix(".thumb") {
                // get the root name of the memory (i.e., without its path extension)
                let name = filename.replacingOccurrences(of: ".thumb", with: "")
                // create a full path from the memory
                let imageURL = getDocumentsDirectory().appendingPathComponent(name + ".jpg")
                // add it to our array
                let memory = Memory(thumbURL: file, imageURL: imageURL, name: name)
                memories.append(memory)
            }
        }
    }

    func saveNewMemory(image: UIImage) {
        // create a unique name for this memory
        let memoryName = "memory-\(Date().timeIntervalSince1970)"
        // use the unique name to create filenames for the full-size image and the thumbnail
        let imageName = memoryName + ".jpg"
        let thumbnailName = memoryName + ".thumb"

        do {
            // create a URL where we can write the JPEG to
            let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
            // convert the UIImage into a JPEG data object
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                // write that data to the URL we created
                try jpegData.write(to: imagePath, options: [.atomicWrite])
            }

            // create thumbnail here
            let thumbPath = getDocumentsDirectory().appendingPathComponent(thumbnailName)
            if let thumbnail = resize(image: image, to: 200) {
               if let jpegData = thumbnail.jpegData(compressionQuality: 0.8) {
                  try jpegData.write(to: thumbPath, options: [.atomicWrite])
               }
            }

            // Add memory to collection
            let memory = Memory(thumbURL: thumbPath, imageURL: imagePath, name: imageName)
            memories.append(memory)

        } catch {
            print("Failed to save to disk.")
        }
    }

    /// This method generates a small 200x200 thumbnail for each picked image
    func resize(image: UIImage, to width: CGFloat) -> UIImage? {
        // calculate how much we need to bring the width down to match our target size
        let scale = width / image.size.width
        // bring the height down by the same amount so that the aspect ratio is preserved
        let height = image.size.height * scale
        // create a new image context we can draw into
        UIGraphicsBeginImageContextWithOptions(CGSize(width: width, height: height), false, 0)
        // draw the original image into the context
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        // pull out the resized version
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        // end the context so UIKit can clean up
        UIGraphicsEndImageContext()
        // send it back to the caller
        return newImage
    }

    /// This method returns the directory where we store data
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    /// These for methods return the URLs for the 4 kinds of assets we store for each Memory
    func imageURL(for memory: URL) -> URL {
       return memory.appendingPathExtension("jpg")
    }

    func thumbnailURL(for memory: URL) -> URL {
       return memory.appendingPathExtension("thumb")
    }

    func audioURL(for memory: URL) -> URL {
       return memory.appendingPathExtension("m4a")
    }

    func transcriptionURL(for memory: URL) -> URL {
       return memory.appendingPathExtension("txt")
    }
}
