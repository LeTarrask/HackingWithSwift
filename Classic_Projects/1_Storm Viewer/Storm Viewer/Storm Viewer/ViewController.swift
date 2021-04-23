//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Alex Luna on 22/04/2021.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareApp))

        performSelector(inBackground: #selector(fetchFiles), with: nil)
    }

    @objc func fetchFiles() {
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(item)
            }

        }

        pictures.sort()

        tableView.performSelector(onMainThread: #selector(UITableView.reloadData),
                                  with: nil,
                                  waitUntilDone: false)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row]

            vc.stringTitle = "\(indexPath.row+1) of \(pictures.count)"
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    @objc func shareApp() {
        let message = "Hey check out this app"
        let vc = UIActivityViewController(activityItems: [message],
                                          applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem =
            navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
}


