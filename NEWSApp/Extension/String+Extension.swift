//
//  String+Extension.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import Foundation

extension String {
    
    var asURL: URL? {
        return URL(string: self)
    }
    
    func encodeUrl() -> String {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed) ?? ""
    }
}
