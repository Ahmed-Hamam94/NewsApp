//
//  MenueCategory.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 03/11/2023.
//

import Foundation

struct MenueCategory {
    let id: String
    let value: String
}

struct CategoryList {
    var items: [MenueCategory] = [
        MenueCategory(id: "general", value: "General"),
        MenueCategory(id: "business", value: "Business"),
        MenueCategory(id: "entertainment", value: "Entertainment"),
        MenueCategory(id: "health", value: "Health"),
        MenueCategory(id: "science", value: "Science"),
        MenueCategory(id: "sports", value: "Sports"),
        MenueCategory(id: "technology", value: "Technology")
    ]
}
