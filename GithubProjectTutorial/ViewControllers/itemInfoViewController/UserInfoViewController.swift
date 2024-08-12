//
//  UserIInfoViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 09/08/24.
//

import UIKit

protocol UserInfoViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for user : User)
    func didTapGetFolowers(for user : User)
}
class UserInfoViewController: BaseNetworkViewController {
    var username : String!
    let headerView = UIView()
    let itemView1 = UIView()
    let itemView2 = UIView()
    let dateLabel = GptBodyLabel(textAlignment: .center)
    var itemsViews: [UIView ] = []
    
    weak var  delegate : FollowersViewDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMainView()
        getUserDetails(username: self.username)
        layoutUI()
    }
    
    func configureMainView(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton        // Do any additional setup after loading the view.
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    func getUserDetails(username : String){
        showLoadingView()
        NetworkManager.shared.getUser(username: username){ [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
                case .success(let user):
                    DispatchQueue.main.async { self.configureUiOnSuccess(user: user) }
                case.failure(let error):
                    self.presentGptAlertOnMainThread(title: "ERROR", message: error.rawValue, buttonTitle: "Dismiss")
                    self.dismissVC()
            }
        }
    }
    
    func configureUiOnSuccess(user : User) {
        let repoVC = GptReposItemViewController(user: user)
        repoVC.delegate = self
        
        let followersVC = GptFollowersItemViewController(user: user)
        followersVC.delegate = self
        
        self.add(childVC: GptUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC:repoVC, to: self.itemView1)
        self.add(childVC: followersVC, to: self.itemView2)
        self.dateLabel.text = "Github since \(user.createdAt.convertToMonthYear())"
    }
    
    func add(childVC : UIViewController, to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

    func layoutUI(){
        let padding : CGFloat = 20
        itemsViews = [ headerView, itemView1, itemView2, dateLabel ]
        for item in itemsViews {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
            NSLayoutConstraint.activate([
                    item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                    item.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
                ])
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: 140),
            
            itemView2.topAnchor.constraint(equalTo : itemView1.bottomAnchor, constant: padding),
            itemView2.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemView2.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
}

extension UserInfoViewController : UserInfoViewControllerDelegate {
    func didTapGithubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGptAlertOnMainThread(title: "Invalid Url", message: "The Url attached is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariViewController(with: user.htmlUrl)
    }
    
    func didTapGetFolowers(for user: User) {
        guard user.followers != 0 else {
                  presentGptAlertOnMainThread(title: "No Followers", message: "\(user.login) has no followers.", buttonTitle: "So Sad")
                  return
              }
              delegate.didRequestFollowers(for: user.login)
              dismissVC()
    }
}
   
