//
//  UIView+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 12/08/24.
//

import UIKit
extension UIView {
    func addSubviews(_ views : UIView...){// variadic parametes
        for view in views {addSubview(view)}
    }
}
