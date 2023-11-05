//
//  DetailsViewModel.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 04/11/2023.
//


import UIKit
import RxSwift
import RxCocoa


protocol DetailsViewModelProtocol: AnyObject {
    
//    var input: DetailsViewModel.Input {get}
//    var output: DetailsViewModel.Output {get}
    
    func viewDidLoad()
    func favoriteButtonIconAndTintColor() -> (UIImage?, UIColor?)
    func toggleFavorite()
    var article: Articles?  {get set}

}

class DetailsViewModel: DetailsViewModelProtocol {
//
//    // input class mn el7aga ely mfrod td5ol ll viewmodel
//    class Input {
//      //  var article: Articles?
//
//    }
//    // output    class mn el7aga ely mfrod ttl3 mn viewmodel
//    class Output {
//
//    }
    var article: Articles?
    
    init(article: Articles) {
        self.article = article
    }
    
//    var input: Input = .init()
//
//    var output: Output = Output()
    
   // private  let bag = DisposeBag()
   
    
    func viewDidLoad(){
   
    }
    
  
    var isArticleFavorited: Bool {
        if let article = article {
            return FavoritesManager.shared.isArticleFavorited(article)
        } else {
            return false
        }
    }

//    func isArticleFavorited(article: Articles) -> Bool {
//        if FavoritesManager.shared.isArticleFavorited(article) {
//            return true
//        }
//        return false
//    }
    
    func favoriteButtonIconAndTintColor() -> (UIImage?, UIColor?) {
       let isFavorite = isArticleFavorited
       let image = UIImage(systemName: isFavorite ? "bookmark.fill" : "bookmark")
       let color = isFavorite ? UIColor(named: "primary") : nil
       return (image, color)
    }
    
    func toggleFavorite() {
        guard let article = article else { return }
            if isArticleFavorited {
                FavoritesManager.shared.removeFavorite(article)
                print("UnSaved")
            } else {
                FavoritesManager.shared.addFavorite(article)
                print("Saved")
            }
        }
 
    
    func removeFavorite(article:Articles) {
        FavoritesManager.shared.removeFavorite(article)
    }
    
    func addFavorite(article:Articles) {
        FavoritesManager.shared.addFavorite(article)
    }

}

