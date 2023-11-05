//
//  EndPoint.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import Foundation

enum EndPoint {
    
    static let base_url = "https://newsapi.org/v2"
     static let api_Key = "d41ea9dc2dfc4cee833ccae98f9e4186"
    
   
    
 
    case allNews(query: String = "", category: String )
 
    var path: String{
        switch self{
            
        case .allNews:
            return "/top-headlines"
        }
    }
  
}
