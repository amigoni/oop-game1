//
//  Orc.swift
//  oop-game1
//
//  Created by Leonardo Amigoni on 10/26/15.
//  Copyright © 2015 Mozzarello. All rights reserved.
//

import Foundation

class Orc: Character {
    init() {
        super.init(startingHP: 80, attackPwr: 15, name: "Orc", characterType: Character.CharacterType.Orc)
    }
}