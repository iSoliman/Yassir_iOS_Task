//
//  CharacterCellViewModel.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import Foundation

struct CharacterCellViewModel {

    let styler: CharacterCellStyling
    
    init(status: String) {
        let characterStatus = CharacterStatus(rawValue: status) ?? CharacterStatus.unknown
        switch characterStatus {
        case .alive:
            styler = BabyBlueCharacterStyling()
        case .dead:
            styler = PinkCharacterStyling()
        case .unknown:
            styler = WhiteCharacterStyling()
        }
    }
}
