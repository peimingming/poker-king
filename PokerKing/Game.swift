//
//  Game.swift
//  PokerKing
//
//  Created by 裴明明 on 2020/3/17.
//  Copyright © 2020 裴明明. All rights reserved.
//

import Foundation

struct Game {
    let players: [Player]
    
    init(players: [Player]) {
        self.players = players
    }
    
    /// Check out as the game is over
    func checkOut() -> [DebtRelationship] {
        /*
         Algorithm:
         
         1. Sort the players in descending order
            player1: 10
            player2: 4
            player3: 2
         
         2. Create the debt relationships as below
            r1 = player2 owes player1 : debt = 10 - 4 = 6
            r2 = player3 owes player1 : debt = 10 - 2 = 8
            r3 = player3 owes player2 : debt = 4 - 2 = 2
         
         3. Reduce unnecessary transfers
            Thinking player3 -> player2 -> player1 flow exists in the above relationships, it'd result in some redundant transfers, which is pretty much like:
            You owe me 1 yuan, and I owe him 1 yuan, then you can give that 1 yuan to him directly.
            or
            You owe me 1 yuan, but I owe him 2 yuan, then you still give that 1 yuan to him and I only need to give him 1 yuan.
            or
            You owe me 2 yuan, and I owe him 1 yuan, then you give each of us (me and him) 1 yuan.
            In other words, player3 might be able to TAKE PART OF THE DEBT of player2.
            The algorithm is as below:
            minDebt = min(r3.debt, r1.debt) = min(6, 2) = 2
            r1.debt = r1.debt - minDebt = 6 - 2 = 4
            r2.debt = r2.debt + minDebt = 8 + 2 = 10
            r3.debt = r3.debt - minDebt = 2 - 2 = 0
        */
        guard players.count == 3 else {
            assertionFailure("There must be 3 players")
            return []
        }
        let descendingOrderedPlayers = players.sorted(by: >)
        let player1 = descendingOrderedPlayers[0]
        let player2 = descendingOrderedPlayers[1]
        let player3 = descendingOrderedPlayers[2]
        var r1 = DebtRelationship(winner: player1, loser: player2, debt: player1.winningCount - player2.winningCount)
        var r2 = DebtRelationship(winner: player1, loser: player3, debt: player1.winningCount - player3.winningCount)
        var r3 = DebtRelationship(winner: player2, loser: player3, debt: player2.winningCount - player3.winningCount)
        let minDebt = min(r3.debt, r1.debt)
        r1.debt = r1.debt - minDebt
        r2.debt = r2.debt + minDebt
        r3.debt = r3.debt - minDebt
        let eligibleRelationships = [r1, r2, r3].filter { $0.debt != 0 }
        return eligibleRelationships
    }
}
