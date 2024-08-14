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
        configureV1()
    }
    
    convenience init(backgroundColor : UIColor, title : String, systemName  : String){
        self.init(frame: .zero)
       set(color: backgroundColor, title: title, systemName: systemName)
    }
    
//    func set(backgroundColor : UIColor, title : String){
//        self.backgroundColor = backgroundColor
//        self.setTitle(title, for: .normal)
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        setTitleColor(.white, for:.normal)
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle:.headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    //ios 15
   private func configureV1(){
       configuration = .tinted()
       configuration?.cornerStyle = .medium
       translatesAutoresizingMaskIntoConstraints = false
    }
func set(color: UIColor, title : String, systemName : String){
        configuration?.title = title
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.image = UIImage(systemName: systemName)
    configuration?.imagePadding = 6
    configuration?.imagePlacement = .leading
    }
}

#Preview{
    GptButton(backgroundColor: .gray, title: "Text Preview", systemName: "pencil")
}
