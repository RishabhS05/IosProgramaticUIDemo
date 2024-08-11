//
//  GptTextField.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 31/07/24.
//

import UIKit

class GptTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false // to use auto layout
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        minimumFontSize = 12
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        returnKeyType = .done
        clearButtonMode = .whileEditing 
        placeholder = "Enter a username"
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
