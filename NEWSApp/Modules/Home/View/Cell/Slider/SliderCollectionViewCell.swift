//
//  SliderCollectionViewCell.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 01/11/2023.
//

import UIKit

class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    lazy var counter = 0
    var timer: Timer?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .yellow
        registerCell()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
        
    }
    @objc private func moveToNext(){
        
    }
    func configure(with model: Articles){
    }
    private func registerCell(){
        collectionView.registerCelNib(cellClass: SliderDetailsCollectionViewCell.self)
    }
}
