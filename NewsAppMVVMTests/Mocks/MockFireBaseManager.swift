//
//  MockFireBaseManager.swift
//  NewsAppMVVMTests
//
//  Created by Yasin Özdemir on 17.03.2024.
//

import Foundation
@testable import NewsAppMVVM
import FirebaseAuth

enum MockFireBaseError :Error{
    case error
}

final class MockFireBaseManager : IFireBaseManager{
    var invokedsignIn = false
    var invokedsignInCount = 0
    var shouldReturnErrorForSignIn = false
    
    func signIn(user: NewsAppMVVM.User, completion: @escaping (Void?, Error?) -> Void) {
        invokedsignIn = true
        invokedsignInCount += 1
        
        if shouldReturnErrorForSignIn{
            completion(nil, MockFireBaseError.error )
        }else{
            completion((), nil)
        }
    }
    var invokedCreateUser = false
    var invokedCreateUserCount = 0
    var shouldReturnErrorForCreateUser = false
    func createUser(user: NewsAppMVVM.User, completion: @escaping (Void?, Error?) -> Void) {
        invokedCreateUser = true
        invokedCreateUserCount += 1
        
        if shouldReturnErrorForCreateUser{
            completion(nil , MockFireBaseError.error)
        }else{
            completion(() , nil)
        }
    }
    var invokedLogOut = false
    var invokedLogOutCount = 0
    func logOut() {
        invokedLogOut = true
        invokedLogOutCount += 1
    }
    
    
}
