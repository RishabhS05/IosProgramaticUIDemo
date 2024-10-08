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
    let callToActionButton = GptButton(backgroundColor : .systemGreen, title : "Get Followers", systemName: SfSymbols.followersLabel)
    var isUsernameEntered : Bool { return !usernameTextfield.text!.isEmpty }
    var logoImageViewTopConstraint : NSLayoutConstraint!
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
        usernameTextfield.text =  ""
        navigationController?.setNavigationBarHidden(false, animated:true)

    }
    func createOnTapDismissKeyboard(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    func configureLogoImageView(){
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: Images.ghLogo )
        //
        let topConstraintConstant : CGFloat  = DeviceType.isiphoneSE || DeviceType.isiphone8Zoomed ? 20 : 80
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField(){
        view.addSubview(usernameTextfield)
        usernameTextfield.delegate = self
        
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
        guard isUsernameEntered else { 
      presentGptAlertOnMainThread(title: "Enter Username", message: "Please Enter a username.", buttonTitle: "Ok")
            return
        }
        usernameTextfield.resignFirstResponder()
       let followerListVC = FollowersViewController(username: usernameTextfield.text!)
     
        navigationController?.pushViewController(followerListVC, animated: true)
    }
}
  
extension SearchViewController : UITextFieldDelegate {
  
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // network call
        followerListCall()
        return true
    }
}

#Preview {
    SearchViewController()
}
