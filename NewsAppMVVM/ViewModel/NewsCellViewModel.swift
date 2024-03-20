//
//  NewsCellViewModel.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 20.02.2024.
//

import Foundation

class NewsCellViewModel{
    
    let title : String
    let description : String
    let imageUrlString : String
    let newUrlString : String
    
    init(title: String, description: String, imageUrlString: String, newUrlString: String) {
        self.title = title
        self.description = description
        self.imageUrlString = imageUrlString
        self.newUrlString = newUrlString
    }
}
