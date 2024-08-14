//
//  UserIInfoViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 09/08/24.
//

import UIKit


class UserInfoViewController: BaseNetworkViewController {
    let scrollView = UIScrollView()
    let contentView = UIView()
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
        getUserDetailsV2(username: self.username)
        configureScrollView()
        layoutUI()
    }
    func configureScrollView(){
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 550),
        ])
    }
    
    func configureMainView(){
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton        // Do any additional setup after loading the view.
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
    
    func  getUserDetailsV2(username : String) {
        Task {
            do {
                let  user =  try await NetworkManagerV2.shared.getUser(username: username)
                configureUiOnSuccess(user: user)
            }catch {
                if let gfError = error as? GPTError {
                    presentGptAlert(title: "ERROR", message: gfError.rawValue, buttonTitle: "Dismiss")
                }else {
                    presentGptDefaultError()
                }
                dismissVC()
            }
        }
        
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
        self.add(childVC: GptUserInfoHeaderViewController(user: user), to: self.headerView)
        self.add(childVC:GptReposItemViewController(user: user,delegate : self), to: self.itemView1)
        self.add(childVC: GptFollowersItemViewController(user: user, delegate: self ), to: self.itemView2)
        self.dateLabel.text = "Github since \(user.createdAt.convertWithDefaultToMonthYear())"
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
            contentView.addSubview(item)
            NSLayoutConstraint.activate([
                    item.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                    item.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -padding)
                ])
        }
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
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

extension UserInfoViewController : UserGoToGithubDelegate, UserGetFollowers {
    func didTapToGithubProfile(for user: User) {
        guard URL(string: user.htmlUrl) != nil else {
            presentGptAlert(title: "Invalid Url", message: "The Url attached is invalid", buttonTitle: "Ok")
            return
        }
        presentSafariViewController(with: user.htmlUrl)
    }
    
    func didTapToGetFollowers(for user: User) {
        guard user.followers != 0 else {
                  presentGptAlert(title: "No Followers", message: "\(user.login) has no followers.", buttonTitle: "So Sad")
                  return
              }
              delegate.didRequestFollowers(for: user.login)
              dismissVC()
    }
}
   
