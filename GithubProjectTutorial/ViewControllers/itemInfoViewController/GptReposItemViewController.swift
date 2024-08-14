//
//  GptReposItemViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import UIKit



protocol UserGoToGithubDelegate: AnyObject {
    func didTapToGithubProfile(for user : User)
}

class GptReposItemViewController : GptItemInfoViewController {
    
    weak var  delegate : UserGoToGithubDelegate!
    
    init(user : User, delegate: UserGoToGithubDelegate!) {
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
        itemInfoViewOne.setItemInfoType(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.setItemInfoType(itemInfoType: .gist, withCount: user.publicGists)
        actionButton.set(color : .systemPurple, title: "Github Profile",systemName: SfSymbols.personLabel)
    }
    override func actionButtonTapped() {
        delegate.didTapToGithubProfile(for: user)
    }
}
