//
//  CharractersFilterHandler.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 23/09/2024.
//

import Combine

enum CharacterStatus: String {

    case alive = "Alive"
    case dead = "Dead"
    case unknown
}

class CharractersFilterHandler {

    //MARK: Private
    private var allCharacters = [CartoonCharacter]()
    private var statusFilter: CharacterStatus?

    //MARK: Internal
    @Published var presentedCharacter = [CartoonCharacter]()
    var hasNoCharacters: Bool { allCharacters.isEmpty }

    func filterCharcterStatus(by status: CharacterStatus) {
        if status == statusFilter {
            statusFilter = nil
            presentedCharacter = allCharacters
        } else {
            statusFilter = status
            presentedCharacter = allCharacters.filter { $0.status == status.rawValue }
        }
    }

    func addNewCharacter(_ characters: [CartoonCharacter]) {
        allCharacters.append(contentsOf: characters)
        if let status = statusFilter {
            presentedCharacter.append(contentsOf: characters.filter { $0.status == status.rawValue })
        } else {
            presentedCharacter.append(contentsOf: characters)
        }
    }
}
