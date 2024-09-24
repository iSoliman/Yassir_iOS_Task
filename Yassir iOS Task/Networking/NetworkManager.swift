//
//  NetworkManager.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Alamofire
import Combine

protocol NetworkManager {

    func fetchData<T: Codable>(_ type: T.Type, with requestBuilder: RequestBuilder) async throws -> T
}

class NetworkManagerImp: NetworkManager {

    static let shared = NetworkManagerImp()
    private let baseURL = "https://rickandmortyapi.com/api"

    private init() {}

    // Use Alamofire to fetch the characters
    func fetchData<T: Codable>(_ type: T.Type, with requestBuilder: RequestBuilder) async throws -> T {
        let url = "\(self.baseURL)\(requestBuilder.url)"
        let method = MethodTypeMapper.map(methodType: requestBuilder.methodType)
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(url, method: method, parameters: requestBuilder.queryParams)
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let objResponse):
                        continuation.resume(returning: objResponse)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
