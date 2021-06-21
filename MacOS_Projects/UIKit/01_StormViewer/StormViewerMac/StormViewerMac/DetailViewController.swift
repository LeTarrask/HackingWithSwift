//
//  DetailViewController.swift
//  StormViewerMac
//
//  Created by tarrask on 18/06/2021.
//

import Cocoa

class DetailViewController: NSViewController {
    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func imageSelected(name: String) {
       imageView.image = NSImage(named: name)
    }
}
