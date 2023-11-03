//
//  ApiResponse.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    //var results: T?
    let status: String?
    let totalResults: Int?
    let articles: T?
}
