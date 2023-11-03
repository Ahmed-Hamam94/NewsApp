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

    @IBOutlet weak var sliderCollectioView: UICollectionView!
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    let bag = DisposeBag()
    var homeViewModel: HomeViewModelProtocol?
    lazy var counter = 0
    var timer: Timer?
    
    lazy var dataSource = RxCollectionViewSectionedReloadDataSource<NewsSection> (configureCell: { dataSource , collectionView, indexPath, item in
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath) as! NewsCollectionViewCell
            cell.configure(with: item)

            return cell
    }, configureSupplementaryView: { dataSource, collectioView, kind, indexPath in
      
        let section = dataSource[indexPath.section]

        if kind == UICollectionView.elementKindSectionHeader{
            let headerC = collectioView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCollectionReusableView", for: indexPath) as! HeaderCollectionReusableView
    
               // headerC.backgroundColor = .red
                headerC.configure()
                return headerC
            }
        return UICollectionReusableView()
        }
    )
    
    
    lazy var sliderDataSource = RxCollectionViewSectionedReloadDataSource<NewsSection> (configureCell: { dataSource , collectionView, indexPath, item in
        //let section = dataSource[indexPath.section]
            
            let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderDetailsCollectionViewCell", for: indexPath) as! SliderDetailsCollectionViewCell
            // Configure the cell with the item from the slider section
            sliderCell.configure(with: item)
        
      //  sliderCell.dataSorcee = dataSource
            return sliderCell
      
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        startTimer()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopTimer()
    }
    private func startTimer(){
        stopTimer()
        guard timer == nil else {return}
        timer = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(moveToNext), userInfo: nil, repeats: true)
    }
    
    private func stopTimer(){
        guard timer != nil else {return}
        timer?.invalidate()
        timer = nil
    }

    @objc private func moveToNext(){
        if let sliderArr = homeViewModel?.output.tenItems.asObservable() {
            sliderArr
                .map { $0.count }
                .subscribe(onNext: { [weak self] count in
                    guard let self else {return}
                    if count > 0 {
                     //   print(count)
                        if self.counter < count - 1 {
                            self.counter += 1
                          //  print(self.counter)
                        } else {
                            self.counter = 0
                        }
                        self.sliderCollectioView.scrollToItem(at: IndexPath(item: self.counter, section: 0), at: .right, animated: true)
                        
                    }
                })
                .disposed(by: bag)
        }
        
        homeViewModel?.viewDidLoad()
        
    }
    
    private func prepareNavigation(){
        navigationController?.navigationBar.tintColor = .systemGray

        let menueBarButtonItem = UIBarButtonItem(image: UIImage(systemName:"line.3.horizontal"), style: .plain, target: self, action: #selector(onMenueButtonClicked))
       // menueBarButtonItem.width = 40
        self.navigationItem.leftBarButtonItem  = menueBarButtonItem

    }
 
    private func registerCell(){
        
        newsCollectionView.registerCelNib(cellClass: NewsCollectionViewCell.self)
        sliderCollectioView.registerCelNib(cellClass: SliderDetailsCollectionViewCell.self)
        
        newsCollectionView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
        sliderCollectioView.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderCollectionReusableView")
      newsCollectionView.collectionViewLayout = layout()
        sliderCollectioView.collectionViewLayout = sliderLayout()
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
        let height = CGFloat(150)
       // let cellHeight: CGFloat = (dataSource.numberOfSections(in: newsCollectionView) == 1) ? 300 : 150

        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        layout.itemSize = CGSize(width: width, height: height)
     return layout
    }
    
    private func sliderLayout()-> UICollectionViewFlowLayout{

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.sectionInset = UIEdgeInsets(top: 0, left: 1, bottom: 0, right: 1)   //bading between sections
        let width = view.frame.width
        let height = CGFloat(300)
      //  let cellHeight: CGFloat = (dataSource.numberOfSections(in: newsCollectionView) == 1) ? 300 : 150

//        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 50)
        layout.itemSize = CGSize(width: width, height: height)
     return layout
    }

    func bindCollectionView(){
        homeViewModel?.output.newssPuplish.map { [NewsSection(original: NewsSection(header: "", items: $0), items: $0)] }
               .bind(to: newsCollectionView.rx.items(dataSource: dataSource))
               .disposed(by: bag)
        
        homeViewModel?.output.tenItems.asObservable().map{ [NewsSection(original: NewsSection(header: "", items: $0), items: $0)] }.bind(to: sliderCollectioView.rx.items(dataSource: sliderDataSource)).disposed(by: bag)
 
    }
}
//MARK: -

extension HomeViewController {
   
}
