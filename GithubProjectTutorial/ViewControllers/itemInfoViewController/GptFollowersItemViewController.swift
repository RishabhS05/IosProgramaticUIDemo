//
//  GptFollowersItemViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import Foundation

protocol UserGetFollowers: AnyObject {
    func didTapToGetFollowers(for user : User)
}

class GptFollowersItemViewController : GptItemInfoViewController  {
    
    weak var delegate : UserGetFollowers!
    
    init(user : User ,delegate: UserGetFollowers!) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems(){
        itemInfoViewTwo.setItemInfoType(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewOne.setItemInfoType(itemInfoType: .following, withCount: user.following)
        actionButton.set(color : .systemGreen, title: "Git Followers",systemName: SfSymbols.followersLabel)
    }
    override func actionButtonTapped() {
        delegate.didTapToGetFollowers(for: user)
    }
    
}
