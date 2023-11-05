//
//  SliderCollectionViewCell.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 01/11/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources



class SliderCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var newssPuplish: PublishSubject<[Articles]> = .init()
    var homeViewModel: HomeViewModelProtocol? = HomeViewModel()
    let bag = DisposeBag()
    lazy var counter = 0
    var timer: Timer?
    var newsArr: PublishSubject<[Articles]> = .init()

    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<NewsSection> (configureCell: { dataSource , collectionView, indexPath, item in
        let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderDetailsCollectionViewCell", for: indexPath) as! SliderDetailsCollectionViewCell
        sliderCell.configure(with: item)
        return sliderCell
    })
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        backgroundColor = .yellow
        
        registerCell()
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
        bindToCollectionView()
        
    }
    @objc private func moveToNext(){
        
    }
    
    func configure(with model: Articles){
        //   print("yuyu \(model)")
        
        
    }
    private func registerCell(){
        collectionView.registerCelNib(cellClass: SliderDetailsCollectionViewCell.self)
    }
    private func bindToCollectionView(){
        //        homeViewModel?.output.newssPuplish.bind(to: collectionView.rx.items(cellIdentifier: String(describing: SliderDetailsCollectionViewCell.self), cellType: SliderDetailsCollectionViewCell.self)) { index , article, cell in
        //
        ////            if let newsArr = self.homeViewModel?.output.newssPuplish{
        ////
        ////            }
        //
        //            cell.configure(with: article)
        //
        //        }.disposed(by: bag)
        //    }
        
        
//        homeViewModel?.output.newssPuplish.map { [NewsSection(original: .newsSection(header: "Test", items: $0), items: $0)] }
//            .bind(to: collectionView.rx.items(dataSource: dataSource))
//            .disposed(by: bag)
    }
}
