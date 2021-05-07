//
//  ViewController.swift
//  Four in a row
//
//  Created by Alex Luna on 07/05/2021.
//

import GameplayKit
import UIKit

class ViewController: UIViewController {
    var placedChips = [[UIView]]()
    var board: Board!

    @IBOutlet var columnButtons: [UIButton]!
    
    @IBAction func makeMove(_ sender: UIButton) {
        let column = sender.tag
        if let row = board.nextEmptySlot(in: column) {
            board.add(chip: board.currentPlayer.chip, in: column)
            addChip(inColumn: column, row: row, color: board.currentPlayer.color)
            continueGame()
        }
    }

    var strategist: GKMinmaxStrategist!

    override func viewDidLoad() {
        super.viewDidLoad()
        for _ in 0 ..< Board.width {
            placedChips.append([UIView]())
        }
        strategist = GKMinmaxStrategist()
        strategist.maxLookAheadDepth = 7
        strategist.randomSource = nil

        resetBoard()
    }

    func updateUI() {
        title = "\(board.currentPlayer.name)'s Turn"

        if board.currentPlayer.chip == .black {
            startAIMove()
        }
    }

    func continueGame() {
        // 1
        var gameOverTitle: String? = nil
        
        // 2
        if board.isWin(for: board.currentPlayer) {
            gameOverTitle = "\(board.currentPlayer.name) Wins!"
        } else if board.isFull() {
            gameOverTitle = "Draw!"
        }

        // 3
        if gameOverTitle != nil {
            let alert = UIAlertController(title: gameOverTitle, message: nil, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Play Again", style: .default) { [unowned self] (action) in
                self.resetBoard()
            }
            alert.addAction(alertAction)
            present(alert, animated: true)
            return
        }

        // 4
        board.currentPlayer = board.currentPlayer.opponent
        updateUI()
    }
    
    func resetBoard() {
        board = Board()

        strategist.gameModel = board

        updateUI()
    }

    func columnForAIMove() -> Int? {
        if let aiMove = strategist.bestMove(for: board.currentPlayer) as? Move {
            return aiMove.column
        }
        return nil
    }

    func addChip(inColumn column: Int, row: Int, color: UIColor) {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        let rect = CGRect(x: 0, y: 0, width: size, height: size)
        if (placedChips[column].count < row + 1) {
            let newChip = UIView()
            newChip.frame = rect
            newChip.isUserInteractionEnabled = false
            newChip.backgroundColor = color
            newChip.layer.cornerRadius = size / 2
            newChip.center = positionForChip(inColumn: column, row: row)
            newChip.transform = CGAffineTransform(translationX: 0, y: -800)
            view.addSubview(newChip)
            UIView.animate(withDuration: 0.5, delay: 0,
                           options: .curveEaseIn, animations: {
                            newChip.transform = CGAffineTransform.identity
                           })
            placedChips[column].append(newChip)
        }
    }

    func makeAIMove(in column: Int) {
        columnButtons.forEach { $0.isEnabled = true }
        navigationItem.leftBarButtonItem = nil
        
        if let row = board.nextEmptySlot(in: column) {
            board.add(chip: board.currentPlayer.chip, in: column)
            addChip(inColumn: column, row:row, color: board.currentPlayer.color)
            continueGame()
        }
    }

    func startAIMove() {
        columnButtons.forEach { $0.isEnabled = false }

        let spinner = UIActivityIndicatorView(style: .gray)
        spinner.startAnimating()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: spinner)
        
        DispatchQueue.global().async { [unowned self] in
            let strategistTime = CFAbsoluteTimeGetCurrent()
            guard let column = self.columnForAIMove() else { return }
            let delta = CFAbsoluteTimeGetCurrent() - strategistTime
            let aiTimeCeiling = 1.0
            let delay = aiTimeCeiling - delta
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.makeAIMove(in: column)
            }
        }
    }

    func positionForChip(inColumn column: Int, row: Int) -> CGPoint {
        let button = columnButtons[column]
        let size = min(button.frame.width, button.frame.height / 6)
        let xOffset = button.frame.midX
        var yOffset = button.frame.maxY - size / 2
        yOffset -= size * CGFloat(row)
        return CGPoint(x: xOffset, y: yOffset)
    }
}

