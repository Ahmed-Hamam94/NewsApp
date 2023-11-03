//
//  UITableView+Extension.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 01/11/2023.
//

import UIKit

extension UITableView{
    
    func registerCelNib<cell: UITableViewCell>(cellClass: cell.Type){
        self.register(UINib(nibName: String(describing: cell.self), bundle: nil), forCellReuseIdentifier: String(describing: cell.self))
    }
}
