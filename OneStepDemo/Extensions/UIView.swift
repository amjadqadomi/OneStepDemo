//
//  UIView.swift
//  OneStepDemo
//
//  Created by Amjad on 11/22/20.
//

import Foundation
import UIKit
extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
}

extension UITableView {
    func removeExtraSeperatorLines() {
        tableFooterView = UIView(frame: CGRect.zero)
    }
}
