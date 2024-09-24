//
//  CharacterListRequestBuilder.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

struct CharacterListRequestBuilder: RequestBuilder {

    //MARK: - Internal
    let url = "/character"
    let methodType: MethodType = .get
    let queryParams: [String : Any]

    //MARK: - Initializer
    init(currentPage: Int) {
        queryParams = ["page": currentPage]
    }
}
