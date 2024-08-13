//
//  GptEmptyStateView.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 09/08/24.
//

import UIKit

class GptEmptyStateView: UIView {
    let messageLabel = GptTitleLabel(textAlignment: .center, fontSize: 28)
    let logoImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
convenience init(message : String){
        self.init(frame: .zero)
        messageLabel.text = message
    
    }
   required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    private func configure(){
        addSubviews(messageLabel,logoImageView)
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        logoImageView.image = UIImage(named: Images.emptyStatePlaceHolder)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo:  leadingAnchor, constant:40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier:1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant : 40)
        ])
    }
}
