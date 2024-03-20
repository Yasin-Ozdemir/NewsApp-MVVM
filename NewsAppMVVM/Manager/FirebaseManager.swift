//
//  FirebaseManager.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 8.02.2024.
//

import Foundation
import FirebaseAuth

protocol IFireBaseManager{
    func signIn(user :User , completion : @escaping (Void? , Error?) -> Void)
    func createUser(user :User ,  completion : @escaping (Void? , Error?) -> Void)
    func logOut()
}
class FirebaseManager : IFireBaseManager{
    
   func signIn(user :User , completion : @escaping (Void? , Error?) -> Void){
        Auth.auth().signIn(withEmail: user.mail, password: user.password) { Result, err in
            if err != nil{
                completion(nil , err!)
                
            }else{
                completion(() , nil)
            }
            
            
        }
    }
    
    func createUser(user :User ,  completion : @escaping (Void? , Error?) -> Void){
        Auth.auth().createUser(withEmail: user.mail, password: user.password) { result, err in
            if err != nil{
                completion(nil , err!)
                }else{
                    completion(() , nil)
                }
        }
    }
    
    func logOut(){
        do{
            try Auth.auth().signOut()
        }catch{
            print("logout error")
        }
    }
}
