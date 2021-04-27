//
//  ViewController.swift
//  Storm Viewer
//
//  Created by Alex Luna on 22/04/2021.
//

import UIKit

class ViewController: UITableViewController {
    var pictures = [Storm]()

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
                let storm = Storm(image: item, timesShown: 0)
                pictures.append(storm)
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
        cell.textLabel?.text = pictures[indexPath.row].image
        cell.detailTextLabel?.text = "Seen \(pictures[indexPath.row].timesShown) times"
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 1: try loading the "Detail" view controller and typecasting it to be DetailViewController
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            // 2: success! Set its selectedImage property
            vc.selectedImage = pictures[indexPath.row].image
            pictures[indexPath.row].timesShown += 1
            print("Image shown \(pictures[indexPath.row].timesShown)")

            vc.stringTitle = "\(indexPath.row+1) of \(pictures.count)"
            // 3: now push it onto the navigation controller
            navigationController?.pushViewController(vc, animated: true)
            tableView.reloadData()
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


