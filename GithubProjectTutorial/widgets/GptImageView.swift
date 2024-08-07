//
//  GptImageView.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

import UIKit

class GptImageView: UIImageView {
    let placeholder = UIImage(named :"avatar-placeholder")!
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
   private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
}
