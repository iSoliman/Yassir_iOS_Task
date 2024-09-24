//
//  CharacterCellStyling.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import SwiftUI

protocol CharacterCellStyling {

    var backgroundColor: Color { get }
    var hasBorder: Bool { get }

    init()
}

struct PinkCharacterStyling: CharacterCellStyling {

    var backgroundColor = Color(red: 251/255, green: 231/255, blue: 235/255)
    var hasBorder = false
}

struct BabyBlueCharacterStyling: CharacterCellStyling {

    var backgroundColor = Color(red: 235/255, green: 246/255, blue: 251/255)
    var hasBorder = false
}

struct WhiteCharacterStyling: CharacterCellStyling {

    var backgroundColor = Color.white
    var hasBorder = true
}
