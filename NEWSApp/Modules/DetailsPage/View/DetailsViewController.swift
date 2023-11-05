//
//  DetailsViewController.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 04/11/2023.
//

import UIKit
import RxSwift
import SDWebImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var newsTitleLabel: UILabel!

    @IBOutlet weak var contentText: UITextView!
    
    @IBOutlet weak var favoriteButton: UIButton!
    
    var detailsViewModel: DetailsViewModelProtocol?
    var bag = DisposeBag()
    
    var article: Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = article {
            detailsViewModel = DetailsViewModel(article: article)

            configure(with: article)
        }
        
//        detailsViewModel?.input.newssPuplish?.asObservable().subscribe(onNext: { [weak self] article in
//            print(article.author)
//            self?.articleImage.sd_setImage(with: article.urlToImage?.asURL)
//        }).disposed(by: bag)
        
       // print(detailsViewModel?.input.newssPuplish)
        // Do any additional setup after loading the view.
    }
    func configure(with model: Articles){
        articleImage.sd_setImage(with: article?.urlToImage?.asURL)
        if let author = model.author {
            let components = author.components(separatedBy: ",")
            authorLabel.text = components.first ?? ""
        }
        dateLabel.text = model.publishedAt
        newsTitleLabel.text = model.title
        contentText.text = model.content ?? "no CCC"
        print(model.description ?? "no  des Content")
    }
    
    func updateFavoriteButtonIcon() {
        let (tuble) = detailsViewModel?.favoriteButtonIconAndTintColor()
        favoriteButton.setImage(tuble?.0, for: .normal)
        favoriteButton.tintColor = tuble?.1
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        detailsViewModel?.toggleFavorite()
        updateFavoriteButtonIcon()
    }
}
