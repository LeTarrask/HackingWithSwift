//
//  NoteDetailView.swift
//  Notes
//
//  Created by Alex Luna on 30/04/2021.
//

import SwiftUI

struct NoteDetailView: View {
    @Binding var text: String

    var body: some View {
        Text($text)
    }
}

struct NoteDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NoteDetailView()
    }
}
