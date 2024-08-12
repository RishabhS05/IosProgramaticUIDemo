//
//  hhhh.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 12/08/24.
//

import Foundation
    //
    //  GptItemInfoViewController.swift
    //  GithubProjectTutorial
    //
    //  Created by Rishabh Shrivastava on 10/08/24.
    //

    import UIKit

    class GptItemInfoViewController: UIViewController {

        let stackView = UIStackView()
        let itemInfoViewOne = GptItemInfoView()
        let itemInfoViewTwo = GptItemInfoView()
        let actionButton = GptButton()
        var user : User!
       weak var delegate : UserInfoViewControllerDelegate!
        
        init(user : User){
            super.init(nibName: nil , bundle: nil)
            self.user = user
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            configureBackgroundView()
            layoutUI()
            configureHorizontalStackView()
            configureActionButton()
        }

       private func  configureBackgroundView(){
           view.layer.cornerRadius = 10
           view.backgroundColor = .secondarySystemBackground
       }
        func configureActionButton(){
            actionButton.addTarget(self , action:#selector(actionButtonTapped), for: .touchUpInside)
        }
        @objc func actionButtonTapped(){
            // do for something in child classes
        }
        
        private func configureHorizontalStackView(){
            stackView.axis = .horizontal
            stackView.distribution = .equalSpacing
            stackView.addArrangedSubview(itemInfoViewOne)
            stackView.addArrangedSubview(itemInfoViewTwo)
        }
        private func layoutUI(){
            view.addSubview(stackView)
            view.addSubview(actionButton)
            stackView.translatesAutoresizingMaskIntoConstraints = false
            let padding : CGFloat = 20
            NSLayoutConstraint.activate([
                stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
                stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                stackView.heightAnchor.constraint(equalToConstant: 50),

                actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
                actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
                actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            ])
            
        }
    }
