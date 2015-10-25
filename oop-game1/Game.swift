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
        player1 = Character(startingHP: 80, attackPwr: 15, name: "Orc", characterType: Character.CharacterType.Orc)
        
        player2 = Character(startingHP: 120, attackPwr: 10, name: "Leo", characterType: Character.CharacterType.Soldier)
    }
    
    func hit (attackingPlayer: Character, defendingPlayer: Character){
        defendingPlayer.beHit(attackingPlayer.attackPwr)
    }
    
    func gameOver () {
        status = Status.gameOver
    }
    
    
}