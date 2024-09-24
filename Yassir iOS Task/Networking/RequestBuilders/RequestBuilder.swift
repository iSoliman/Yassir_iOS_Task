//
//  RequestBuilder.swift
//  Yassir iOS Task
//
//  Created by Islam Soliman on 21/09/2024.
//

import Foundation

protocol RequestBuilder {

    var url: String { get }
    var queryParams: [String: Any] { get }
    var methodType: MethodType { get }
}
