//
//  GptItemInfoView.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import UIKit
  
enum ItemInfoType{
    case gist,repos,followers, following
}

class GptItemInfoView: UIView {
 
    let symbolImageView = UIImageView()
    let countLabel = GptTitleLabel(textAlignment: .center, fontSize: 14)
    let titleLabel = GptTitleLabel(textAlignment: .left, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.tintColor = .label
        symbolImageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
        
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor , constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo:  titleLabel.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
        
    }
    
    func setItemInfoType(itemInfoType : ItemInfoType, withCount count : Int){
     
        switch itemInfoType{
            case .following : 
                symbolImageView.image = UIImage(systemName:SfSymbols.followings )
                titleLabel.text = "Following"
            case .gist:
                symbolImageView.image = UIImage(systemName:SfSymbols.gist )
                titleLabel.text = "Pubilc Gists"
            case .repos:
                symbolImageView.image = UIImage(systemName:SfSymbols.repos )
                titleLabel.text = "Pubilc Repos"
            case .followers:
                symbolImageView.image = UIImage(systemName:SfSymbols.followers )
                titleLabel.text = "Followers"
        }
        countLabel.text = String(count)
    }
}
