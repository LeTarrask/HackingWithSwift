//
//  ViewController.swift
//  Shopping List
//
//  Created by Alex Luna on 22/04/2021.
//

import UIKit

class ViewController: UITableViewController {
    var shoppingList: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: self,
                                                            action: #selector(addItem))
        let exportButton = UIBarButtonItem(barButtonSystemItem: .action,
                                           target: self,
                                           action: #selector(shareList))

        navigationItem.rightBarButtonItems = [addButton, exportButton]

        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash,
                                                           target: self,
                                                           action: #selector(clearList))
    }

    @objc func shareList() {
        let title = "Here's my shopping list"
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list, title],
                                          applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem =
            navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

    @objc func clearList() {
        shoppingList = [String]()
        tableView.reloadData()
    }

    @objc func addItem() {
        let ac = UIAlertController(title: "Enter item",
                                   message: nil,
                                   preferredStyle: .alert)
        ac.addTextField()
        let submitAction = UIAlertAction(title: "Submit",
                                         style: .default) { [weak self, weak ac] action in
            guard let item = ac?.textFields?[0].text else { return }
            self?.shoppingList.append(item)
            self?.tableView.reloadData()
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
    }

    // TableView Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        shoppingList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

