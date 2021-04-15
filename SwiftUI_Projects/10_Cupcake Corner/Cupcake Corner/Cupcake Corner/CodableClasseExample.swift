//
//  ContentView.swift
//  Cupcake Corner
//
//  Created by Alex Luna on 12/04/2021.
//

import SwiftUI

struct CodableClasseExample: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

class User: ObservableObject, Codable {
    @Published var name = "Paul Hudson"

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy:
                                                CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
    }

    func encode(to encoder: Encoder) throws {
       var container = encoder.container(keyedBy: CodingKeys.self)
       try container.encode(name, forKey: .name)
    }
}

enum CodingKeys: CodingKey {
    case name
}

struct CodableClasseExample_Previews: PreviewProvider {
    static var previews: some View {
        CodableClasseExample()
    }
}
