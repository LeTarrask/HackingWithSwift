//
//  MenusView.swift
//  MacTechnique
//
//  Created by tarrask on 18/06/2021.
//

import SwiftUI

struct MenusView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct MenusView_Previews: PreviewProvider {
    static var previews: some View {
        MenusView()
    }
}

// This is kind of a SwiftUI hack, because IBActions are some storyboard thing. Since there's no Main.Storyboard, I'd guess this is kinda more complicated, and Paul Hudson's tutorial is still not up to date. Skipping this part for now.
class Commands {
   @IBAction func showSelection(_ sender: Any) { }
}
