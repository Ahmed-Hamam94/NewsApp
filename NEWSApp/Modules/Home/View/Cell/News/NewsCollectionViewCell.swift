//
//  NewsCollectionViewCell.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 01/11/2023.
//

import UIKit
import SDWebImage

class NewsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var newsImageView: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var newsTitleLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        authorLabel.preferredMaxLayoutWidth = contentView.frame.width - newsImageView.frame.width - 20
        newsTitleLabel.preferredMaxLayoutWidth = contentView.frame.width - newsImageView.frame.width - 20
        
        authorLabel.numberOfLines = 0
        authorLabel.lineBreakMode = .byWordWrapping

        newsTitleLabel.numberOfLines = 0
        newsTitleLabel.lineBreakMode = .byTruncatingTail
        
        newsImageView.layer.cornerRadius = 20
    }

    func configure(with model: Articles){
        let imgUrl = model.urlToImage?.encodeUrl().asURL
        newsImageView.sd_setImage(with: imgUrl)
        
        if let author = model.author {
            let components = author.components(separatedBy: ",")
            authorLabel.text = components.first ?? ""
        }
       
        newsTitleLabel.text = model.title ?? ""
        dateLabel.text = model.publishedAt
    }
}
