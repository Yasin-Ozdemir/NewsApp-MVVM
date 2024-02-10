//
//  SignPagesViewModel.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 9.02.2024.
//

import Foundation
import FirebaseAuth
class SignPagesViewModel{
    private init(){
        
    }
   
    
    static var signPagesVM = SignPagesViewModel()
    private let firebaseManager = FirebaseManager()
   
    func signIn(mail : String , password :String , completion : @escaping (Error?)-> Void) {
        let user = User(mail: mail , password:  password)
        firebaseManager.signIn(user: user) { result, error in
            if error != nil{
                completion(error!)
            }
           
        }
    }
    
    func createUser(mail :String , password :String , completion : @escaping (Error?)-> Void){
        let newUser = User(mail: mail, password: password)
        firebaseManager.createUser(user: newUser) { result, error in
            if error != nil{
                completion(error!)
            }
            
        }
    }
  
}
