//
//  GptFollowersItemViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import Foundation

class GptFollowersItemViewController : GptItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
     
    private func configureItems(){
        itemInfoViewTwo.setItemInfoType(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewOne.setItemInfoType(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Git Followers")
    }
}
