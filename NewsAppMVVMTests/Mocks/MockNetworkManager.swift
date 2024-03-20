//
//  MockNetworkManager.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 17.03.2024.
//

import Foundation
@testable import NewsAppMVVM
enum MockNetworkErrors : Error{
    case error
}
final class MockNetworkManager : INetworkManager{
    
    var invokedDownloadNewData = false
    var invokedDownloadNewDataCount = 0
    var shouldReturnError = false
    
    var downloadNewDataResponse : New = New(success: true, result: [Results(key: " dsad", url: " dsada", description: "dsad ", image: " dsad", name: " ds", source: "aa ", date: "dsda ") , Results(key: " afsaff", url: "fsaffsa ", description: "fsafsf ", image: " fsafsfsa", name: " dsda", source: "gsdg ", date: "dsadas ")])
    func downloadNewData(page: Int, category: String, completion: @escaping ([Results]?, Error?) -> Void) {
         
        invokedDownloadNewData = true
        invokedDownloadNewDataCount += 1
        
        if shouldReturnError{
            completion(nil ,MockNetworkErrors.error )
        }else{
            completion(downloadNewDataResponse.result  , nil)
        }
        
    }
    
    
}
