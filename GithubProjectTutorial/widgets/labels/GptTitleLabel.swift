//
//  GptTitleLabel.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 02/08/24.
//

import UIKit

class GptTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame:frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment : NSTextAlignment, fontSize : CGFloat){
        self.init(frame : .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight : .bold)
    configure()
    }

   private func configure(){
       textColor = .label
       adjustsFontSizeToFitWidth = true // adjust the font size  automatically according to width.
       minimumScaleFactor = 0.9 // how much we will want to reduce the font size.
       lineBreakMode = .byTruncatingTail // long text will show ... at end.
       translatesAutoresizingMaskIntoConstraints = false // to use auto layout.
    }
        
}
