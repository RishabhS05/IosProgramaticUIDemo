//
//  FollowersCell.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

import UIKit

class FollowersCell: UICollectionViewCell {
    static let reuserId = "FollowerCell"
    let avatarImageView = GptImageView(frame: .zero)
   
    let userLabel = GptTitleLabel(textAlignment: .center, fontSize: 16)
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        init(){
            super.init(frame: .zero)
        }
  
   func set(follower : Follower){
        userLabel.text = follower.login
       avatarImageView.downLoadImage(from : follower.avatarUrl)
    }
    
   private func configure(){
        addSubviews(avatarImageView, userLabel)
       let padding :CGFloat = 8
       // As of ios 15 we dont want to pin this to contentView
       NSLayoutConstraint.activate([
        avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
        avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
        avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        //label constraints
        userLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
        userLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
        userLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
        userLabel.heightAnchor.constraint(equalToConstant: 20)
       ])
   }
    
}
