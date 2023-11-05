//
//  UIView+Extension.swift
//  NEWSApp
//
//  Created by Ahmed Hamam on 04/11/2023.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
         get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
