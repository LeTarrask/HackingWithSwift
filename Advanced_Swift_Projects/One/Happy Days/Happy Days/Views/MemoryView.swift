//
//  MemoryView.swift
//  Happy Days
//
//  Created by Alex Luna on 17/06/2021.
//

import SwiftUI

struct MemoryView: View {
    init(_ memory: Memory) {
        self.memory = memory
    }

    let memory: Memory

    @State private var isRecording = false

    var body: some View {
        Image(uiImage: UIImage(contentsOfFile: memory.thumbURL.path)!)
            .resizable()
            .frame(width: 200, height: 200)
            .colorMultiply(isRecording ? .red.opacity(0.3) : .clear)
            .onLongPressGesture {
                if !isRecording {

                    isRecording = true
                    print(isRecording)
                } else {

                    isRecording = false
                    print(isRecording)
                }
            }
    }
}

struct MemoryView_Previews: PreviewProvider {
    static var previews: some View {
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "africa", ofType: "jpg")!)
        let memory = Memory(thumbURL: url, imageURL: url, name: "teste")
        return MemoryView(memory)
    }
}
