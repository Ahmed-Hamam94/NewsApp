//
//  TabBarVC.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 31/10/2023.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConfigureTabBAr()
    }

// MARK: - Private Functions
    
    private func ConfigureTabBAr() {
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: SearchViewController())
        let vc3 = UINavigationController(rootViewController: FavoriteViewController())
        let vc4 = UINavigationController(rootViewController: AccountViewController())
        // add image
        vc1.tabBarItem.image = UIImage(systemName: "square.stack.3d.up")
        vc2.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        vc3.tabBarItem.image = UIImage(systemName: "bookmark")
        vc4.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        // add title

//        vc1.title = "Home"
//        vc2.title = "Search"
//        vc3.title = "BookMark"
//        vc4.title = "Account"
        
        tabBar.tintColor = .label
        
        setViewControllers([vc1,vc2,vc3,vc4], animated: true)
    }
    

 
}
