//
//  MenueListController.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 03/11/2023.
//

import UIKit

protocol MenuListDelegate {
    func didSelectCategory(_ category: MenueCategory)
}

class MenueListController: UIViewController {
    
    //MARK: - Outlets
    let tableView : UITableView = {
        let tableview = UITableView(frame: .zero, style: .grouped)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableview
    }()
    
    let menueViewModel = MenueViewModel()
    public var menuDelegate: MenuListDelegate?
    var selectedIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .cyan
        setUpUI()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        assignFramesToUI()
    }
    // MARK: - Private Functions
    
    private func setUpUI(){
        view.backgroundColor = .systemBackground
        addSubbViews()
    }
    private func addSubbViews(){
        view.addSubview(tableView)
        
    }
    
    private func assignFramesToUI(){
        tableView.frame = view.bounds
    }

}

extension MenueListController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menueViewModel.menueItems.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if #available(iOS 14.0, *) {
            var content = cell.defaultContentConfiguration()
            content.text = menueViewModel.menueItems[indexPath.row].value
            cell.contentConfiguration = content
            cell.accessoryType = .disclosureIndicator
        } else {
            // Fallback on earlier versions
            cell.textLabel?.text = menueViewModel.menueItems[indexPath.row].value
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.row > 0 {
            let selectedCategory = menueViewModel.menueItems[indexPath.row]
                menuDelegate?.didSelectCategory(selectedCategory)
                selectedIndexPath = indexPath
                tableView.reloadData()
       // }
    }
    
    
}
