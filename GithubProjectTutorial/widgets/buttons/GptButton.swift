//
//  GptButton.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 31/07/24.
//

import UIKit

class GptButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
   convenience init(backgroundColor : UIColor, title : String){
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle( title, for: .normal)
    
    }
    
    func set(backgroundColor : UIColor, title : String){
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        setTitleColor(.white, for:.normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle:.headline)
    }
}
