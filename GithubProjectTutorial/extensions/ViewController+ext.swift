//
//  ViewController+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 04/08/24.
//

import UIKit


// the scope is limited to the file only.
fileprivate var containerView : UIView!

extension UIViewController {
    func  presentGptAlertOnMainThread(title : String,message : String ,  buttonTitle: String){
        DispatchQueue.main.async{
            let alertVC = GptAlertViewController(alertTitle :title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
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
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }

    }
}
