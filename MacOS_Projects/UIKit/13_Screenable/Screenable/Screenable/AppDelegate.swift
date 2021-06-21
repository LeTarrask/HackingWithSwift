//
//  AppDelegate.swift
//  Screenable
//
//  Created by tarrask on 21/06/2021.
//

import Cocoa

@main
class AppDelegate: NSObject, NSApplicationDelegate {



    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        NSColorPanel.shared.showsAlpha = true
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

