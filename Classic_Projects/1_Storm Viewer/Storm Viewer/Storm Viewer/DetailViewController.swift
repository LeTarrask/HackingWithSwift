//
//  DetailViewController.swift
//  Storm Viewer
//
//  Created by Alex Luna on 22/04/2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var selectedImage: String?
    var stringTitle: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let kTitle = stringTitle {
            title = kTitle
        }
//        title = selectedImage
        navigationItem.largeTitleDisplayMode = .never

        if let imageToLoad = selectedImage {
           imageView.image  = UIImage(named: imageToLoad)
        }
    }

    // Hides navBar when user taps
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       navigationController?.hidesBarsOnTap = true
    }

    // Stop hiding navBar when user taps
    override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       navigationController?.hidesBarsOnTap = false
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
