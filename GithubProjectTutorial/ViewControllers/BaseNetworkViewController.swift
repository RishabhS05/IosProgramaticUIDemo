//
//  BaseNetworkViewController.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 12/08/24.
//

import UIKit
import SafariServices

class BaseNetworkViewController: UIViewController {
    
    var containerView : UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
        ///Show  Loading View from screen
        func showLoadingView(){
            containerView = UIView(frame: view.bounds)
            containerView.backgroundColor = .systemBackground
            containerView.alpha  = 0
            view.addSubview(containerView)
            UIView.animate(withDuration: 0.25 ){  self.containerView.alpha  = 0.8 }
            let activityIndicator = UIActivityIndicatorView(style: .large)
            containerView.addSubview(activityIndicator) 
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)])
            activityIndicator.startAnimating()
        }
        
        ///Remove Loading View from screen
        func dismissLoadingView() {
            DispatchQueue.main.async {
                self.containerView.removeFromSuperview()
                self.containerView = nil
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
}
