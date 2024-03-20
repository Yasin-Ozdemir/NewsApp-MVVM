//
//  HomePageViewModelTests.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 17.03.2024.
//

import XCTest
@testable import NewsAppMVVM

final class HomePageViewModelTests: XCTestCase {
    var homePageVM : HomePageViewModel!
    var view  = MockHomeViewController()
    var manager  = MockNetworkManager()
    var firebaseManager  = MockFireBaseManager()
    
    override  func setUp() {
        super.setUp()
        homePageVM = .init(networkManager: manager, firebaseManager: firebaseManager, delegate: view)
      
    }
    
    override func tearDown() {
        super.tearDown()
    }
   
    func test_fetchNewDatas(){
        XCTAssertFalse(manager.invokedDownloadNewData)
        XCTAssertEqual(homePageVM.newCellViewModels.count, 0)
        XCTAssertFalse(view.invokedReloadCollectinView)
        
        homePageVM.fetchNewDatas()
        
        
        XCTAssertEqual(manager.invokedDownloadNewDataCount , 1)
        XCTAssertEqual(view.invokedReloadCollectinViewCount, 1)
        XCTAssertEqual(homePageVM.newCellViewModels.count, 2)
        
    }
    
    func test_fetchNewDatasForErrorResponse(){
        XCTAssertFalse(manager.invokedDownloadNewData)
        XCTAssertEqual(homePageVM.newCellViewModels.count, 0)
        XCTAssertFalse(view.invokedReloadCollectinView)
        manager.shouldReturnError = true
        
        homePageVM.fetchNewDatas()
        XCTAssertEqual(manager.invokedDownloadNewDataCount , 1)
        XCTAssertEqual(view.invokedReloadCollectinViewCount, 0)
        XCTAssertEqual(homePageVM.newCellViewModels.count, 0)
    }
    
    func test_fetchMoreNewsData(){
        XCTAssertFalse(manager.invokedDownloadNewData)
        let cellViewModelCount = homePageVM.newCellViewModels.count
        
        homePageVM.fetchMoreNewsData()
        
        XCTAssertEqual(manager.invokedDownloadNewDataCount , 1)
        XCTAssertNotEqual(cellViewModelCount, homePageVM.newCellViewModels.count)
    }
    
    
    func test_fetchMoreNewsDataForErrorResponse(){
        XCTAssertFalse(manager.invokedDownloadNewData)
        let cellViewModelCount = homePageVM.newCellViewModels.count
        manager.shouldReturnError = true
        
        homePageVM.fetchMoreNewsData()
        XCTAssertEqual(manager.invokedDownloadNewDataCount , 1)
        XCTAssertEqual(homePageVM.newCellViewModels.count , cellViewModelCount)
    }
    
    func test_numberofItemsInSectionForFirstSection(){
        let section = 0
        
       let response = homePageVM.numberofItemsInSection(at: section)
        XCTAssertEqual(response, 5)
    }
    
    func test_numberofItemsInSectionForSecondSection(){
        let section = 1
        
        let response = homePageVM.numberofItemsInSection(at: section)
        XCTAssertEqual(response, 0)
    }
    
    func test_getCategory(){
        let indexPath = IndexPath(row: 1, section: 0)
        var response : String?
        
        response = homePageVM.getCategory(indexPath: indexPath)
        
        XCTAssertNotNil(response)
        
    }
    
    func test_logOut(){
        XCTAssertFalse(firebaseManager.invokedLogOut)
        
        homePageVM.logOut()
        
        XCTAssertEqual(firebaseManager.invokedLogOutCount, 1)
    }
    
    
}

