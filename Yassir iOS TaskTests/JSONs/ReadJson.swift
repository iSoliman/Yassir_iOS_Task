//
//  ReadJson.swift
//  Yassir iOS TaskTests
//
//  Created by Islam Soliman on 23/09/2024.
//

import Foundation

class ReadJson {

    static func readJSONFile<T: Codable>(_ type: T.Type, _ fileName: String) -> T {
        guard let url = Bundle(for: ReadJson.self).url(forResource: fileName, withExtension: "json") else {
            fatalError("Missing file: person.json")
        }
        let data = try! Data(contentsOf: url)
        let decoder = JSONDecoder()
        let jsonObject = try! decoder.decode(T.self, from: data)
        return jsonObject
        
    }
}
