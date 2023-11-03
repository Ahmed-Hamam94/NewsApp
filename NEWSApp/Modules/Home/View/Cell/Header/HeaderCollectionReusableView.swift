//
//  HeaderCollectionReusableView.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 02/11/2023.
//

import UIKit

class HeaderCollectionReusableView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Latest News"
        return label
    }()
    
    func configure(){
        addSubview(headerLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        headerLabel.frame = bounds
    }
}
