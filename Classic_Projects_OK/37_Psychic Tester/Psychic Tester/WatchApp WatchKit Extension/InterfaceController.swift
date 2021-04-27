//
//  InterfaceController.swift
//  WatchApp WatchKit Extension
//
//  Created by Alex Luna on 26/04/2021.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate {
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }

    func session(_ session: WCSession,
                 didReceiveMessage message: [String : Any]) {
        WKInterfaceDevice().play(.click)
    }

    @IBOutlet weak var hideButton: WKInterfaceButton!

    @IBAction func hideWelcomeText() {
        welcomeText.setHidden(true)
        hideButton.setHidden(true)
    }

    @IBOutlet weak var welcomeText: WKInterfaceLabel!

    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    override func willActivate() {
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
}
