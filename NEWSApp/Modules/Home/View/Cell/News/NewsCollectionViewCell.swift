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
//       contentView.backgroundColor = .blue
//        authorLabel.backgroundColor = .gray
        newsImageView.backgroundColor = .brown
    }

    func configure(with model: Articles){
        let imgUrl = model.urlToImage?.encodeUrl().asURL
        newsImageView.sd_setImage(with: imgUrl)
        authorLabel.text = model.author
        newsTitleLabel.text = model.title
        dateLabel.text = model.publishedAt
    }
}
