//
//  GptReposItemViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import UIKit

class GptReposItemViewController : GptItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
     
    private func configureItems(){
        itemiinfoViewtwo.setItemInfoType(itemInfoType: .repos, withCount: user.publicRepos)
        itemiinfoViewtwo.setItemInfoType(itemInfoType: .gist, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
}
