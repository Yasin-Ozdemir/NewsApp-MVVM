//
//  MockHttpClient.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 20.03.2024.
//

import Foundation
@testable import NewsAppMVVM
class MockHttpClient : IHttpClient{
    var invokedExecute = false
    var invokedExecuteCount = 0

    func execute(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) {
        invokedExecute = true
        invokedExecuteCount += 1
    }
    
    
}
