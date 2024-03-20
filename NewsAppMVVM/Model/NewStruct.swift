//
//  NewStruct.swift
//  NewsAppMVVM
//
//  Created by Yasin Özdemir on 28.12.2023.
//

import Foundation
// MARK: - New
struct New: Codable {
    let success: Bool
    let result: [Results]
}

// MARK: - Result
struct Results: Codable {
    let key: String
    let url: String
    let description: String
    let image: String
    let name, source, date: String
}
