//
//  SearchViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 31/07/24.
//

import UIKit

class SearchViewController: UIViewController {

    let logoImageView = UIImageView()
    let usernameTextfield =  GptTextField()
    let callToActionButton = GptButton(backgroundColor : .systemGreen, title : "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        viewConfiguration()
    }
    
    func viewConfiguration(){
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createOnTapDismissKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true

    }
    func createOnTapDismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(usernameTextfield)
        NSLayoutConstraint.activate([
            usernameTextfield.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 48),
            usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant:-50),
            usernameTextfield.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
  
    func configureCallToActionButton(){
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self , action: #selector(followerListCall), for: .touchUpInside)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func followerListCall(){
        
    }
}
  
extension SearchViewController : UISearchTextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // network call
        followerListCall()
        return true
    }
}
