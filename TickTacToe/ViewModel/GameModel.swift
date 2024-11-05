//
//  GameModel.swift
//  TickTacToe
//
//  Created by Isuru Ariyarathna on 2024-11-05.
//

import SwiftUI

enum Player {
    case x
    case o
}

class GameModel: ObservableObject {
    @Published var board: [Player?] = Array(repeating: nil, count: 9)
    @Published var activePlayer: Player = .x
    @Published var winner: Player?
    @Published var isGameOver: Bool = false
    @AppStorage("xScore") var xScore: Int = 0
    @AppStorage("oScore") var oScore: Int = 0
    
    func buttonTapped(at index: Int) {
        guard board[index] == nil && winner == nil else {
            return
        }
        
        board[index] = activePlayer
        
        if !board.contains(where: { $0 == nil }) {
            self.winner = nil
            self.isGameOver = true
            return
        }
        
        if let winner = checkForWinner() {
            self.winner = winner
            self.isGameOver = true
            
            if winner == .x {
                UserDefaults.standard.set(xScore + 1, forKey: "xScore")
            }
            if winner == .o {
                UserDefaults.standard.set(oScore + 1, forKey: "oScore")
            }
            
            return
        } else {
            activePlayer = (activePlayer == .x) ? .o : .x
        }
    }
    
    func buttonLabel(at index: Int) -> String {
        if let player = board[index] {
            return player == .x ? "X" : "O"
        }
        
        return ""
    }
    
    func resetGame() {
        board = Array(repeating: nil, count: 9)
        activePlayer = .x
        winner = nil
    }
    
    func checkForWinner() -> Player? {
        let winningCombinations: [(Int, Int, Int)] = [
            (0, 1, 2),
            (3, 4, 5),
            (6, 7, 8),
            (0, 3, 6),
            (1, 4, 7),
            (2, 5, 8),
            (0, 4, 8),
            (2, 4, 6)
        ]
        
        let activePlayer = self.activePlayer
        
        for combination in winningCombinations {
            if board[combination.0] == activePlayer && board[combination.1] == activePlayer && board[combination.2] == activePlayer {
                return activePlayer
            }
        }
        
        return nil
    }
}
