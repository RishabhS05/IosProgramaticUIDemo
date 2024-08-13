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
            let alertVC = GptAlertViewController(alertTitle :title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
    }
    
    
        /// The is a method to display the alert message to the user on screen
        /// - Parameters:
        ///   - title: Title Header message of the alert dialog
        ///   - message: Discription message of alert dialog
        ///   - buttonTitle: Button label of alert dialog.
        func  presentGptAlert(title : String,message : String ,  buttonTitle: String){
                let alertVC = GptAlertViewController(alertTitle :title, message: message, buttonTitle: buttonTitle)
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                self.present(alertVC, animated: true)
        }
    
    
        /// The is a method to display the alert message to the user on screen
        /// - Parameters:
        ///   - title: Title Header message of the alert dialog
        ///   - message: Discription message of alert dialog
        ///   - buttonTitle: Button label of alert dialog.
        func  presentGptDefaultError(){
                let alertVC = GptAlertViewController(alertTitle :"Something went wrong", message: "Something is not working correctly. Please try again later.", buttonTitle: "OK")
                alertVC.modalPresentationStyle = .overFullScreen
                alertVC.modalTransitionStyle = .crossDissolve
                self.present(alertVC, animated: true)
        }
    
    
    
        /// Launch Safari web link inside the application without sending to safari browser
        /// - Parameter url: url link
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
