//
//  ViewController.swift
//  Guess the Flag
//
//  Created by Alex Luna on 22/04/2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var message: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            message = "Your score is \(score)."
        } else {
            title = "Wrong"
            score -= 1
            message = "This is the flag of \(countries[sender.tag].capitalized). \nYour score is \(score)."
        }

        if questions <= 10 {
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else {
            let ac = UIAlertController(title: "Game Over", message: "Your final score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Reset game", style: .default, handler: resetGame))
            present(ac, animated: true)
        }
    }

    var correctAnswer = 0
    var countries = [String]()
    var score = 0
    var questions = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]

        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(showScore))

        askQuestion(action: nil)
    }

    func resetGame(action: UIAlertAction!) {
        correctAnswer = 0
        score = 0
        questions = 0
        askQuestion(action: nil)
    }

    func askQuestion(action: UIAlertAction!) {
        questions += 1
        countries.shuffle()

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        correctAnswer = Int.random(in: 0...2)
        title = "Guess: \(countries[correctAnswer].uppercased()) - Current Score: \(score)"
    }

    @objc func showScore() {
        let title = "Your score"
        let message = "Your score is \(score)."

        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
    }
}

