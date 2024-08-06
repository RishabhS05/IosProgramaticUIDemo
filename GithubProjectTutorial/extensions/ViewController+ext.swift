//
//  ViewController+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 04/08/24.
//

import UIKit

extension UIViewController {
    func  presentGptAlertOnMainThread(title : String,message : String ,  buttonTitle: String){
        DispatchQueue.main.async{
            let alertVC = GptAlertViewController(alertTitle :title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
