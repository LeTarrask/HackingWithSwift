//
//  NewWindowView.swift
//  MacTechnique
//
//  Created by tarrask on 18/06/2021.
//

import SwiftUI

// This is the generated view
struct NewWindowView: View {
    var body: some View {
        Text("Second View")
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// This is the view that calls other views using the DetailWindowController class
struct MainView: View {
    var body: some View {
        Button("Show New Window") {
            let controller = DetailWindowController(rootView: NewWindowView())
            controller.window?.title = "New window"
            controller.showWindow(nil)
        }
    }
}

struct MainViewView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

// This class generates another window with a SwiftUI view inside it
class DetailWindowController<RootView: View>: NSWindowController {
    convenience init(rootView: RootView) {
        let hostingController = NSHostingController(rootView: rootView.frame(width: 300, height: 400))
        let window = NSWindow(contentViewController: hostingController)
        window.setContentSize(NSSize(width: 300, height: 400))
        self.init(window: window)
    }
}
