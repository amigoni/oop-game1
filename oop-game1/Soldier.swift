//
//  Soldier.swift
//  oop-game1
//
//  Created by Leonardo Amigoni on 10/26/15.
//  Copyright © 2015 Mozzarello. All rights reserved.
//

import Foundation

class Soldier: Character {
    init() {
        super.init(startingHP: 120, attackPwr: 10, name: "Soldier", characterType: Character.CharacterType.Soldier)
    }
}