//
//  Player.swift
//  PokerKing
//
//  Created by 裴明明 on 2020/3/17.
//  Copyright © 2020 裴明明. All rights reserved.
//

import Foundation

struct Player {
    let id: Int
    let name: String
    let winningCount: Int
}

extension Player: Comparable {
    static func < (lhs: Player, rhs: Player) -> Bool {
        lhs.winningCount < rhs.winningCount
    }
}
