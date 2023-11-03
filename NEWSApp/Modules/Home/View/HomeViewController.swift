//
//  HomeViewController.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
 
class HomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var newsCollectionView: UICollectionView!
    let bag = DisposeBag()
    var homeViewModel: HomeViewModelProtocol?
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<NewsSection> (configureCell: { dataSource , collectionView, indexPath, item in
        //let section = dataSource[indexPath.section]
        if indexPath.item == 0 {
       
            let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
            // Configure the cell with the item from the slider section
    sliderCell.configure(with: item)
            return sliderCell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            cell.configure(with: item)

            return cell
        }
//        switch section{
//                case .sliderSection(_, let items):
//                    let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for: indexPath) as! SliderCollectionViewCell
//                    // Configure the cell with the item from the slider section
//            sliderCell.configure(with: item)
//                    return sliderCell
//        case .newsSection(_, let items):
//                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
//                    cell.configure(with: item)
//
//                    return cell
//                }
   return UICollectionViewCell()

    }, configureSupplementaryView: { dataSource, collectioView, kind, indexPath in
      
        let section = dataSource[indexPath.section]

        if kind == UICollectionView.elementKindSectionHeader{
            let headerC = collectioView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
            switch section {
                     case let .sliderSection(header, _):
                         // Configure the header view for the slider section
                print(header)

                headerC.backgroundColor = .blue
                return headerC
                     case let .newsSection(header, _):
                         // Configure the header view for the news section
                print(header)
                headerC.backgroundColor = .red

                headerC.configure()
                return headerC
                
            }
//            headerC.configure()
//            return headerC
        }
        
       return UICollectionReusableView()
    }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News"
        homeViewModel = HomeViewModel()
        prepareNavigation()
      //  configureCollectioView()
        registerCell()
        bindCollectionView()
        //subscribeWithCollectionView()
        homeViewModel?.viewDidLoad()
    }

    private func prepareNavigation(){
        navigationController?.navigationBar.tintColor = .systemGray

        let menueBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"line.3.horizontal"), style: .plain, target: self, action: #selector(onMenueButtonClicked))
       // menueBarButtonItem.width = 40
        self.navigationItem.leftBarButtonItem  = menueBarButtonItem

    }
    
//    private func configureCollectioView(){
//        newsCollectionView.delegate = self
//        newsCollectionView.dataSource = self
//    }
    private func registerCell(){
        //newsCollectionView.registerCelNib(cellClass: SliderCollectionViewCell.self)
        newsCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCollectionViewCell")
        newsCollectionView.registerCelNib(cellClass: NewsCollectionViewCell.self)
        
        
        newsCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
      newsCollectionView.collectionViewLayout = layout()

    }
    
    @objc func onMenueButtonClicked(_ sender: Any){
        print("SearchButtonClicked")
    }
    
    func subscribeWithCollectionView(){
     
        homeViewModel?.output.newssPuplish.bind(to: newsCollectionView.rx.items(cellIdentifier: String(describing: NewsCollectionViewCell.self), cellType: NewsCollectionViewCell.self)) { index , article, cell in
           // let indexPath = IndexPath(item: index, section: 0)
            cell.configure(with: article)
     
        }.disposed(by: bag)
        
        //newsCollectionView.rx.itemSelected
    }
    
    private func layout()-> UICollectionViewFlowLayout{

        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)   //bading between sections
        let width = view.frame.width-20
        let height = width/2-20
        let cellHeight: CGFloat = (dataSource.numberOfSections(in: newsCollectionView) == 1) ? 300 : 150

        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        layout.itemSize = CGSize(width: width, height: cellHeight)
     return layout
    }

    func bindCollectionView(){
      //  newsCollectionView.rx.setDelegate(self).disposed(by: bag)
        // Create the RxCollectionViewSectionedReloadDataSource
        
//        homeViewModel?.output.newssPuplish.bind(to: self.newsCollectionView.rx.items(dataSource: dataSource)).disposed(by: bag)
        
//        titleForHeaderInSection: { dataSorce, sectionIndex in
//            return dataSorce[sectionIndex].model
//        }
        
//        let sliderItems: [String] = ["as","sd","ff"]
//
//        let sliderSection = NewsSection.sliderSection(header: "hello", items: sliderItems)
//        let newsSection = NewsSection.newsSection(header: "Test", items: newssPuplish)
//
//        Observable.just([sliderSection, newsSection])
//            .bind(to: newsCollectionView.rx.items(dataSource: dataSource))
//            .disposed(by: bag)
        
        homeViewModel?.output.newssPuplish.map { [NewsSection(original: .newsSection(header: "Test", items: $0), items: $0)] }
               .bind(to: newsCollectionView.rx.items(dataSource: dataSource))
               .disposed(by: bag)
        
//        homeViewModel?.output.newssPuplish.bind(to: newsCollectionView.rx.items(dataSource: dataSource)).disposed(by: bag)
    
        
        // Bind the data to your collection view
      
    }
}
//MARK: -
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 4
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        return UICollectionViewCell()
//    }
//
//}

//MARK: - UICollectionView
extension HomeViewController {
   
}
