//
//  SettingsScreen.swift
//  FlashZilla
//
//  Created by Alex Luna on 14/04/2021.
//

import SwiftUI

struct SettingsScreen: View {
    @Binding var recoverWrong: Bool

    var body: some View {
        Form {
            Toggle("Reshuffle wrong answers", isOn: $recoverWrong)
        }
    }
}

struct SettingsScreen_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen(recoverWrong: .constant(true))
    }
}
