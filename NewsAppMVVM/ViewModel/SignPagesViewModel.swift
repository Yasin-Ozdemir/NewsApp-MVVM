//
//  SignPagesViewModel.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 9.02.2024.
//

import Foundation
import FirebaseAuth
class SignPagesViewModel{
    
    var firebaseManager : IFireBaseManager = FirebaseManager()
   
    func signIn(mail : String , password :String , completion : @escaping (Void?,Error?)-> Void) {
        let user = User(mail: mail , password:  password)
        firebaseManager.signIn(user: user) { _, error in
            if error != nil{
                completion(nil,error!)
            }else{
                completion(() , nil)
            }
           
        }
    }
    
    func createUser(mail :String , password :String , completion : @escaping (Error?)-> Void){
        let newUser = User(mail: mail, password: password)
        firebaseManager.createUser(user: newUser) { _, error in
            if error != nil{
                completion(error!)
            }else{
                completion(nil)
            }
            
        }
    }
  
}
