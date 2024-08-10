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
        itemiinfoViewtwo.setItemInfoType(itemInfoType: .repos, withCount: user.followers)
        itemiinfoViewtwo.setItemInfoType(itemInfoType: .gist, withCount: user.following)
        actionButton.set(backgroundColor: .systemPurple, title: "Git Followers")
    }
}
