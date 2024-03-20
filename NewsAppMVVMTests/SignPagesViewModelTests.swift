//
//  SignPagesViewModelTests.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 19.03.2024.
//

import XCTest
@testable import NewsAppMVVM
final class SignPagesViewModelTests: XCTestCase {
    var viewModel : SignPagesViewModel!
    let fireBaseManager = MockFireBaseManager()
    override  func setUp() {
        super.setUp()
        viewModel = .init()
        viewModel.firebaseManager = fireBaseManager
    }
    
    override  func tearDown() {
        super.tearDown()
    }
    
   func test_signIn(){
       XCTAssertFalse(fireBaseManager.invokedsignIn)
       
       let mail = " example@example.com"
       let password = "example123"
       
       viewModel.signIn(mail: mail, password: password) { _, err in
           XCTAssertEqual(self.fireBaseManager.invokedsignInCount, 1)
           XCTAssertNil(err)
       }
    }
    
    func test_signInForErrorResponse(){
        XCTAssertFalse(fireBaseManager.invokedsignIn)
        fireBaseManager.shouldReturnErrorForSignIn = true
        let mail = " example@example.com"
        let password = "example123"
        
        viewModel.signIn(mail: mail, password: password) { _, err in
            XCTAssertEqual(self.fireBaseManager.invokedsignInCount, 1)
            XCTAssertNotNil(err)
        }
    }
    
    func test_createUser(){
        
        XCTAssertFalse(fireBaseManager.invokedCreateUser)
        let mail = " example@example.com"
        let password = "example123"
        viewModel.createUser(mail: mail, password: password) { err in
            XCTAssertEqual(self.fireBaseManager.invokedCreateUserCount, 1)
            XCTAssertNil(err)
        }
    }
    
    func test_createUserForErrorResponse(){
        
        XCTAssertFalse(fireBaseManager.invokedCreateUser)
        fireBaseManager.shouldReturnErrorForCreateUser = true
        let mail = " example@example.com"
        let password = "example123"
        viewModel.createUser(mail: mail, password: password) { err in
            XCTAssertEqual(self.fireBaseManager.invokedCreateUserCount, 1)
            XCTAssertNotNil(err)
        }
    }

}
