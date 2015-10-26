//
//  Game.swift
//  oop-game1
//
//  Created by Leonardo Amigoni on 10/25/15.
//  Copyright © 2015 Mozzarello. All rights reserved.
//

import Foundation

class Game {
    enum Status {
        case playing
        case gameOver
    }
    
    var player1: Character!
    var player2: Character!
    var status: Status = Status.gameOver
    
    var _winnner: String = ""
    
    
    func startGame () {
        status = Status.playing
    }
    
    func hit (attackingPlayer: Character, defendingPlayer: Character){
        defendingPlayer.beHit(attackingPlayer.attackPwr)
    }
    
    func gameOver () {
        status = Status.gameOver
    }
    
}