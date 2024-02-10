//
//  NetworkManager.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 28.12.2023.
//

import Foundation

class NetworkManager{
    
    static let shared = NetworkManager()
    private init(){
        
    }
 
    
    func downloadNewData(page : Int ,category : String , completion : @escaping ([Result]? , Error?) -> Void){
        print("------süreç başlıyo ------")
     
        let headers = [
          "content-type": "application/json",
          "authorization": "apikey 6wOrtjL1u8ZNe5XN1CAapA:68K6juL2CyTJej26IXAJdt"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://api.collectapi.com/news/getNews?country=tr&tag=\(category)&paging=\(page)")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
          if (error != nil) {
            print("server error")
          } else {
              print("------süreç başladı ------")
            let httpResponse = response as? HTTPURLResponse
              if httpResponse?.statusCode == 200{
                  if let data = data{
                      do{
                          let new = try JSONDecoder().decode(New.self, from: data)
                          completion(new.result , nil)
                          
                      }catch{ print("decode error")}
                 
                  }else{
                      print("data error")
                  }
              }else{
                  print("service error")
              }
          }
        })

        dataTask.resume()
    }
}
