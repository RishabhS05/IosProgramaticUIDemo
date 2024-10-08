//
//  UIFavoriteViewCell.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 11/08/24.
//

import UIKit

class UIFavoriteViewCell : UITableViewCell {
   static let  reuseID  = "FavoriteCell"
    let avatarImageView  = GptImageView(frame: .zero)
    let usernameLabel = GptTitleLabel(textAlignment: .left, fontSize: 26)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite :Follower){
        usernameLabel.text = favorite.login
        avatarImageView.downLoadImage(from: favorite.avatarUrl)
    }
    
   private func configure(){
        addSubviews(avatarImageView,usernameLabel)
       accessoryType = .detailDisclosureButton
       let padding : CGFloat = 12
       NSLayoutConstraint.activate([
        
        avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
        avatarImageView.heightAnchor.constraint(equalToConstant:60),
        avatarImageView.widthAnchor.constraint(equalToConstant: 60),
        
        usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
        usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: padding),
        usernameLabel.heightAnchor.constraint(equalToConstant: 40)
       ])
    }
}
