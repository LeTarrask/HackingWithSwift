//
//  ViewController.swift
//  Debugging
//
//  Created by Alex Luna on 23/04/2021.
//

import UIKit

class ViewController: UIViewController {

    let value = 8

    override func viewDidLoad() {
        super.viewDidLoad()

        print("I'm inside the viewDidLoad() method!")


        print(1, 2, 3, 4, 5, separator: "-")

        print("Some message", terminator: "")

        assert(value == 8, "Value is bugged")

        for i in 1 ... 100 {
           print("Got number \(i)")
        }
    }


}

