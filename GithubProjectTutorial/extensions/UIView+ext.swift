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
    
    func pinToEdges(of superview :UIView){
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo:superview.topAnchor),
           trailingAnchor.constraint(equalTo:superview.trailingAnchor),
            leadingAnchor.constraint(equalTo:superview.leadingAnchor),
           bottomAnchor.constraint(equalTo:superview.bottomAnchor),
        ])
    }
}
