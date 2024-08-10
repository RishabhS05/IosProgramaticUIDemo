//
//  UserIInfoViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 09/08/24.
//

import UIKit

class UserIInfoViewController: UIViewController {
    var username : String!
    let headerView = UIView()
    let itemView1 = UIView()
    let itenView2 = UIView()
    var itemsViews: [UIView ] = []
    
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
                    DispatchQueue.main.async {
                        self.add(childVC: GptUserInfoHeaderViewController(user: user), to: self.headerView)
                    }
                case.failure(let error):
                    self.presentGptAlertOnMainThread(title: "ERROR", message: error.rawValue, buttonTitle: "Dismiss")
                    self.dismissVC()
            }
        }
    }
    
    func add(childVC : UIViewController, to containerView : UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    func layoutUI(){
        let padding : CGFloat = 20
        itemsViews = [ headerView, itemView1, itenView2 ]
        for item in itemsViews {
            item.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(item)
            NSLayoutConstraint.activate([
                    item.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                    item.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding)
                ])
        }
        itemView1.backgroundColor = .brown
        itenView2.backgroundColor = .darkGray
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemView1.topAnchor.constraint(equalTo: headerView.bottomAnchor,constant: padding),
            itemView1.heightAnchor.constraint(equalToConstant: 140),
            
            itenView2.topAnchor.constraint(equalTo : itemView1.bottomAnchor, constant: padding),
            itenView2.heightAnchor.constraint(equalToConstant: 140)
        ])
    }
}
