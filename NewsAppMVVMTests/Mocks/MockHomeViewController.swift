//
//  MockHomeViewController.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 17.03.2024.
//

import Foundation
@testable import NewsAppMVVM

final class MockHomeViewController : IHomePageViewController{
    var invokedReloadCollectinView = false
    var invokedReloadCollectinViewCount = 0
    
    func reloadCollectinView(flag: Bool) {
        invokedReloadCollectinView = true
        invokedReloadCollectinViewCount += 1
    }
    
    
}
