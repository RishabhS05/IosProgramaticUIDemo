//
//  GptuserInfoHeaderViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import UIKit

class GptUserInfoHeaderViewController: UIViewController {
    let userAvatarImageView = GptImageView(frame: .zero)
    let usernameLebel = GptTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GptSecondoryTitleLabel(fontsize: 18)
    let locationImage = UIImageView()
    let locationLabel = GptSecondoryTitleLabel(fontsize: 18)
    let bioLabel = GptBodyLabel(textAlignment: .left)
    var user : User!
    init(user: User){
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubviews(userAvatarImageView,usernameLebel, nameLabel,locationImage,bioLabel,locationLabel)
        configureView()
        configureUIElements()
    }
    func configureUIElements(){
        userAvatarImageView.downLoadImage(from : user.avatarUrl)
        usernameLebel.text = user.login
        nameLabel.text = user.name ?? ""
        locationLabel.text = user.name ?? "No Location"
        bioLabel.text = user.bio ?? "No Bio Label"
        bioLabel.numberOfLines = 3
        locationImage.image = SfSymbols.location 
        locationImage.tintColor = .secondaryLabel
    }
    
    func configureView(){
        let padding : CGFloat = 20
        let textImagePadding : CGFloat = 12
        locationImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userAvatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant:padding),
            userAvatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userAvatarImageView.heightAnchor.constraint(equalToConstant: 90),
            userAvatarImageView.widthAnchor.constraint(equalToConstant: 90),
            
            usernameLebel.topAnchor.constraint(equalTo: userAvatarImageView.topAnchor),
            usernameLebel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: textImagePadding),
            usernameLebel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            usernameLebel.heightAnchor.constraint(equalToConstant:40),
            
            nameLabel.centerYAnchor.constraint(equalTo: userAvatarImageView.centerYAnchor, constant:8),
            nameLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant:textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            locationImage.bottomAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor),
            locationImage.leadingAnchor.constraint(equalTo: userAvatarImageView.trailingAnchor, constant: textImagePadding),
            locationImage.widthAnchor.constraint(equalToConstant: 20),
            locationImage.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImage.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor,constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
    
            bioLabel.topAnchor.constraint(equalTo: userAvatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: userAvatarImageView.leadingAnchor),
            bioLabel.trailingAnchor .constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        
    }
}
