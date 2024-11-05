//
//  ContentView.swift
//  TickTacToe
//
//  Created by Isuru Ariyarathna on 2024-11-05.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameVM = GameModel()
    
    var body: some View {
        VStack {
           Text("Tick Tac Toe")
                .font(.system(size: 45, weight: .heavy))
            
            VStack(spacing: 10) {
                Text("X Score: \(gameVM.xScore)")
                    .font(.system(size: 20, weight: .semibold))
                    
                Text("O Score: \(gameVM.oScore)")
                    .font(.system(size: 20, weight: .semibold))
            }
            .padding(.top, 15)
            .padding(.bottom, 25)
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3)) {
                ForEach(0..<9) { index in
                    Button{
                        gameVM.buttonTapped(at: index)
                    } label: {
                        Text(gameVM.buttonLabel(at: index))
                            .frame(width: 100, height: 100)
                            .foregroundColor(.white)
                            .font(.system(size: 50, weight: .heavy))
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            
            Button {
                gameVM.resetGame()
            } label: {
                Text("Play Again")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .padding(.top, 50)
        }
        .padding()
        .alert(isPresented: $gameVM.isGameOver) {
            if gameVM.winner == .x {
                Alert(title: Text("Playet X Wins!"), dismissButton: .default(Text("Got it!")))
            } else if gameVM.winner == .o {
                Alert(title: Text("Playet O Wins!"), dismissButton: .default(Text("Got it!")))
            } else {
                Alert(title: Text("Draw!"), dismissButton: .default(Text("Got it!")))
            }
        }
    }
}

#Preview {
    ContentView()
}
