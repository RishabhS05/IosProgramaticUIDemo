//
//  GptAlertViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 02/08/24.
//

import UIKit

class GptAlertViewController: UIViewController {

    let containerView  = GPTViewBackground()
    let titleLabel = GptTitleLabel(textAlignment: .center, fontSize: 20)
    let messageLabel = GptBodyLabel(textAlignment: .center)
    let actionButton = GptButton(backgroundColor: .systemPink, title:    "Ok", systemName: SfSymbols.ok)
    var  alertTitle : String?
    var message : String?
    var buttonTitle : String?
    let padding : CGFloat = 20
    init(alertTitle :String, message : String , buttonTitle : String){
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.buttonTitle = buttonTitle
        self.message = message
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        configureUI()
    }
    func configureUI(){
        view.addSubviews(containerView,titleLabel,actionButton,messageLabel)
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureMessageLabel()
      
    }
 
    func configureContainerView(){
        NSLayoutConstraint.activate([containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                                     containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                                     containerView.widthAnchor.constraint(equalToConstant: 280),
                                     containerView.heightAnchor.constraint(equalToConstant: 220)
                                    ])
    }
    func configureTitleLabel(){
        titleLabel.text = alertTitle ?? "Something went wrong"
         
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
                                     titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                                     titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 28)
                                     ])
    }
    
    func configureButton(){
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
                                     actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                                     actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                                     actionButton.heightAnchor.constraint(equalToConstant: 44)
                                    ])

    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    func configureMessageLabel(){
        messageLabel.text = message ?? "Unable to cpmolete request"
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([ messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding),
                                      messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor , constant: -padding),
                                      messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                                      messageLabel.bottomAnchor.constraint(equalToSystemSpacingBelow: actionButton.topAnchor, multiplier: -12)
        ])
        
    }
}
