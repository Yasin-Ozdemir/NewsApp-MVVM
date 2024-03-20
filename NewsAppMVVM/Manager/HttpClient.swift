//
//  HttpClient.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 20.03.2024.
//

import Foundation
protocol IHttpClient{
    func execute(request : URLRequest , completion : @escaping (Result<Data,Error>)->Void)
}
class HttpClient : IHttpClient{
    
    func execute(request : URLRequest , completion : @escaping (Result<Data,Error>)->Void){
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
          if (error != nil) {
            print("server error")
          } else {
              print("------süreç başladı ------")
            let httpResponse = response as? HTTPURLResponse
              if httpResponse?.statusCode == 200{
                  if let data = data{
                      completion(.success(data))
                 
                  }
              }else{
                  print("service error")
                  completion(.failure(Error.self as! Error))
              }
          }
        })

        dataTask.resume()
    }
}
