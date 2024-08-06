//
//  FollowersViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 02/08/24.
//

import UIKit

class FollowersViewController: UIViewController {
    var  username: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        NetworkManager.shared.getFollowers(for: username, page: 100){
            (followers, errorMessage) in
            guard let followers = followers else {
                self.presentGptAlertOnMainThread(title: "ERROR", message: errorMessage!.rawValue, buttonTitle: "OK")
                return
            }
            print("followers.count = \(followers.count)")
            print(followers)
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true) 
    }


}
