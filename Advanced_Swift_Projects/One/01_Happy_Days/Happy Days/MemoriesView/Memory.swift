//
//  Memory.swift
//  Happy Days
//
//  Created by tarrask on 22/06/2021.
//

import SwiftUI

struct Memory: Identifiable, Equatable {
    let url: URL
    let id: UUID = UUID()
    
    func imageURL() -> URL {
        url.appendingPathExtension("jpg")
    }
    
    func thumbnailURL() -> URL {
        url.appendingPathExtension("thumb")
    }
    
    func audioURL() -> URL {
        url.appendingPathExtension("m4a")
    }
    
    func transcriptionURL() -> URL {
        url.appendingPathExtension("txt")
    }
}
