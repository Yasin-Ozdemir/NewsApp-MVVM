//
//  NetworkManagerTest.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 19.03.2024.
//

import XCTest
@testable import NewsAppMVVM
final class NetworkManagerTest: XCTestCase {
    let httpClient  = MockHttpClient()
    var networkManager : NetworkManager!
    override func setUp() {
        super.setUp()
         networkManager = NetworkManager()
        networkManager.httpClient = httpClient
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func test_downloadNewData(){
        XCTAssertFalse(httpClient.invokedExecute)
        let page = 1
        let category = "economy"
        
        networkManager.downloadNewData(page: page, category: category) { _, _ in
            XCTAssertTrue(self.httpClient.invokedExecute)
            XCTAssertEqual(self.httpClient.invokedExecuteCount, 1)
        }
        
    }
    
    

}
