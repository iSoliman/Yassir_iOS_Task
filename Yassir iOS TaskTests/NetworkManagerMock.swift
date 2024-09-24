//
//  NetworkManagerMock.swift
//  Yassir iOS TaskTests
//
//  Created by Islam Soliman on 23/09/2024.
//

import Foundation
@testable import Yassir_iOS_Task

class NetworkManagerMock: NetworkManager {

    let jsonFile: String
    var shouldSucceed = true
    static let errorMsg = "Mock Networ Error"
    
    init(jsonFile: String) {
        self.jsonFile = jsonFile
    }

    func fetchData<T>(_ type: T.Type, with requestBuilder: any Yassir_iOS_Task.RequestBuilder) async throws -> T where T : Decodable, T : Encodable {
        if shouldSucceed {
            return ReadJson.readJSONFile(T.self, jsonFile)
        } else {
            let localizedDescription = NSLocalizedString(Self.errorMsg, comment: "")
            let error = NSError(
                domain: "",
                code: 1001,
                userInfo: [NSLocalizedDescriptionKey: localizedDescription])
            throw error
        }
    }
    

    
}
