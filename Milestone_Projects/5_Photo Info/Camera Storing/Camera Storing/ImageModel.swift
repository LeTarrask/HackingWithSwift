//
//  ImageModel.swift
//  Camera Storing
//
//  Created by Alex Luna on 28/04/2021.
//

import Foundation
import SwiftUI

struct ImageModel: Codable {
    var description: String

    var id: UUID

    init() {
        self.id = UUID()
        self.description = ""
    }

    var imageName: String {
        id.description
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

    var imageView: Image? {
        let url = Self.documentsFolder.appendingPathComponent(imageName)
        do {
            let imageData = try Data(contentsOf: url)
            guard let uiImage = UIImage(data: imageData) else { return nil }

            return Image(uiImage: uiImage)
        } catch {
            print("Failed to load data \(error)")
        }
        return nil
    }
}


