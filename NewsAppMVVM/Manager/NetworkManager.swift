//
//  NetworkManager.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 28.12.2023.
//

import Foundation

protocol INetworkManager{
    func downloadNewData(page : Int ,category : String , completion : @escaping ([Results]? , Error?) -> Void)
}
class NetworkManager : INetworkManager{
    var httpClient : IHttpClient = HttpClient()
   
    func downloadNewData(page : Int ,category : String , completion : @escaping ([Results]? , Error?) -> Void){
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
        
        httpClient.execute(request: request as URLRequest) { result in
            switch result{
            case .success(let data) :
                do{
                  let new =   try JSONDecoder().decode(New.self, from: data)
                    completion(new.result, nil)
                }catch{}
            case .failure(let err) : completion(nil , err)
            }
        }
        
    }
}
