//
//  SliderDetailsCollectionViewCell.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 02/11/2023.
//

import UIKit
import SDWebImage
import RxSwift
import RxDataSources

class SliderDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var newsImage: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!

    let bag = DisposeBag()
  
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       // backgroundColor = .cyan
        newsImage.layer.cornerRadius = 20
     
    }
    

    
    func configure(with model: Articles){
       // print("yuyu \(model)")
        let imgUrl = model.urlToImage?.encodeUrl().asURL
        newsImage.sd_setImage(with: imgUrl)
        
        if let author = model.author {
            let components = author.components(separatedBy: ",")
            authorLabel.text = components.first ?? ""
        }
        titleLabel.text = model.title ?? ""
    }
}
