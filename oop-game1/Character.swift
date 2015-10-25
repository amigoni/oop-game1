//
//  Character.swift
//  oop-game1
//
//  Created by Leonardo Amigoni on 10/25/15.
//  Copyright © 2015 Mozzarello. All rights reserved.
//

import Foundation

class Character {
    enum CharacterType {
        case Soldier
        case Orc
    }
    
    private var _hp: Int = 100
    private var _attackPwr: Int = 10
    private var _name: String = "Player"
    private var _characterType = CharacterType.Soldier
    
    var hp: Int {
        return _hp
    }
    
    var attackPwr: Int {
        return _attackPwr
    }
    
    var name: String {
        return _name
    }
    
    var characterType: CharacterType {
        return _characterType
    }
    
    var isAlive: Bool {
        get {
            if _hp >= 0 {
                return true
            }
            
            return false
        }
    }
    
    init (startingHP: Int, attackPwr: Int, name: String, characterType: CharacterType) {
        self._hp = startingHP
        self._attackPwr = attackPwr
        self._name = name
        self._characterType = characterType
    }
    
    func beHit (attackPwr: Int) -> Bool {
        self._hp -= attackPwr
        
        return true
    }
}