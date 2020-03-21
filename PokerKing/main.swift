//
//  main.swift
//  PokerKing
//
//  Created by 裴明明 on 2020/3/4.
//  Copyright © 2020 裴明明. All rights reserved.
//

import Foundation

/// Initialize the players, there must be 3
let players = [Player(id: 0, name: "Mother", winningCount: 6),
               Player(id: 1, name: "Wife", winningCount: 5),
               Player(id: 2, name: "Me", winningCount: 3)]

func checkOut() {
    let game = Game(players: players)
    let debtRelationships = game.checkOut()
    
    guard !debtRelationships.isEmpty else {
        print("Haha, a draw game")
        return
    }

    debtRelationships.forEach {
        print("Player [\($0.loser.name)] gives [\($0.winner.name)]: \($0.debt)")
    }
}

checkOut()
