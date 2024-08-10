//
//  ViewController+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 04/08/24.
//

import UIKit
import SafariServices


// the scope is limited to the file only.
fileprivate var containerView : UIView!

extension UIViewController {
    
    /// The is a method to display the alert message to the user on screen
    /// - Parameters:
    ///   - title: Title Header message of the alert dialog
    ///   - message: Discription message of alert dialog
    ///   - buttonTitle: Button label of alert dialog.
    func  presentGptAlertOnMainThread(title : String,message : String ,  buttonTitle: String){
        DispatchQueue.main.async{
            let alertVC = GptAlertViewController(alertTitle :title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    ///Show  Loading View from screen
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha  = 0
        view.addSubview(containerView)
        UIView.animate(withDuration: 0.25 ){  containerView.alpha  = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)])
        activityIndicator.startAnimating()
    }
    
    ///Remove Loading View from screen
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }

    }
    
    /// Method will called to handle if no data is available for any screen after calling any api.
    /// - Parameters:
    ///   - message: display message to handle empty data.
    ///   - view: the view on which the emptystateUI will populate
    func showEmptyStateView(with message : String, in view : UIView){
        let emptyStateView = GptEmptyStateView(message: message)
        emptyStateView.frame = view.bounds   
        view.addSubview(emptyStateView)
    }
    
    func presentSafariViewController(with url : String){
        guard let url = URL(string: url) else {
            presentGptAlertOnMainThread(title: "Invalid Url", message: "The Url attached is invalid", buttonTitle: "Ok")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated : true)
    }
}
