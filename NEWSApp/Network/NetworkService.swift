//
//  NetworkService.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import Foundation

protocol ServiceProtocol {
    
    func fetchNews(query: String, category: String, completion: @escaping (Result<[Articles], APIError>)-> Void)
}
//extension ServiceProtocol {
//    func fetchNews(query: String, category: String,parameter: [String:Any]? = nil, completion: @escaping (Result<[Articles], APIError>)-> Void) {}
//}

class NewsService: ServiceProtocol {
    
    let networkManager = NetworkManager()
    
    func fetchNews(query: String = "", category: String = "", completion: @escaping (Result<[Articles], APIError>) -> Void) {
        
         var parameters: [String:Any]? {
             switch EndPoint.allNews() {
              case .allNews(let query, let category):
                  return [
                      "q": query,
                      "country": "Us",
                      "apiKey": EndPoint.api_Key,
                      "category": category
                  ]
              }
          }
        
        networkManager.request(endPoint: EndPoint.allNews(query: query, category: category), method: .Get,parameters: parameters, completion: completion)
    }
    
    
}
