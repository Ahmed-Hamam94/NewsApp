//
//  HomeViewModel.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 01/11/2023.
//

import Foundation
import RxSwift
import RxCocoa

// ay viewmodel will inherit from it cuz ana ht3aml m3 ay viewmodel 3n tre2 input & output
protocol ViewModel: AnyObject {
    associatedtype Input
    associatedtype Output
}

protocol HomeViewModelProtocol: AnyObject {
    
    var input: HomeViewModel.Input {get}
    var output: HomeViewModel.Output {get}
  //  var postsPuplish: PublishSubject<[Post]> {get}
    func viewDidLoad(category: String?)

}

enum HomeBinding {
    case showHud
    case dismissHud
    case succeedMessage(String)
    case failMessage(String)
}


class HomeViewModel: HomeViewModelProtocol, ViewModel {
  
   
    
    // input class mn el7aga ely mfrod td5ol ll viewmodel
    class Input {
        var newsService: ServiceProtocol?
        var bindingState: PublishSubject<HomeBinding> = .init()
    }
    // output    class mn el7aga ely mfrod ttl3 mn viewmodel
    class Output {
        var newssPuplish: PublishSubject<[Articles]> = .init()
        var tenItems:PublishSubject<[Articles]> = .init()
    }
    
    var input: Input = .init()
    
    var output: Output = Output()
    
   // private var collectedAllPostsPublish: PublishSubject<[Post]> = .init()
    private  let bag = DisposeBag()
    
    init(newsService: ServiceProtocol = NewsService()){
        self.input.newsService = newsService
    }
    
    func viewDidLoad(category: String? = nil){
        callPostFromApi(category: category ?? "general")
       // "general"
    }
    
    private func callPostFromApi(category: String){
       input.bindingState.onNext(.showHud)
     
       input.newsService?.fetchNews(query: "", category: category) { [weak self] result in
           guard let self else {return}
           switch result {
           case .success(let news):
               print("news: \(news)")
               let filteredNews = news.filter({ $0.title != "[Removed]"})
               let limited = Array(filteredNews.prefix(10))
               
               self.output.newssPuplish.onNext(filteredNews)
               self.output.tenItems.onNext(limited)
           case .failure(let error):
               print("error: \(error)")
           }
       }
       DispatchQueue.main.asyncAfter(deadline: .now() + 2){
          // self.collectedAllPostsPublish.onNext(posts)
           self.input.bindingState.onNext(.dismissHud)
       }
       
    }
    
    
//    func getTenItems()-> Observable<[Articles]> {
//        let sliderNews = self.newssPuplish.take(5)
//        return sliderNews
//    }
   
}

