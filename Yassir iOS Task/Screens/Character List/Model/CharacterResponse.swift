//
//  CharacterResponse.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

struct CartoonCharacter: Codable {

    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let location: Location

    static let previewCharacter = CartoonCharacter(
        id: 821,
        name: "Gotron",
        status: "unknown",
        species: "Robot",
        image: "https://rickandmortyapi.com/api/character/avatar/821.jpeg",
        gender: "Male", 
        location: .init(name: "Citadel of Ricks", url: "https"))
}

struct Location: Codable {

    let name: String
    let url: String
}

struct CharacterResponse: Codable {

    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let results: [CartoonCharacter]
    let info: Info
}
