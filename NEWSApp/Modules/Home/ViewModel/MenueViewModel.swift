//
//  MenueViewModel.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 03/11/2023.
//

import Foundation


class MenueViewModel {
    var menueItems: [MenueCategory] = CategoryList().items
    
    var onSucces: (()->())?
    var onError: ((_ errorStr: String)->())?
    
    init() {
        fetchNewsData(category: "general")
    }
    
    func fetchNewsData(category: String) {
        
    }
    
//    func cellForRow(at indexPath: IndexPath) -> Article? {
//        return newsData[indexPath.row]
//    }
//
//    func numberOfRowss(in section: Int) -> Int {
//
//        return 0
//    }
    
   
}
