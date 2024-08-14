//
//  GptImageView.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 07/08/24.
//

import UIKit

class GptImageView: UIImageView {
    
    let placeholder = UIImage(named :Images.placeholderImage)!
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            configure()
        }
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
   private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholder
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
extension GptImageView {
    
     public func downLoadImage(from url :String) {
         Task {
                let image = await NetworkManagerV2.shared.downloadImage(from: url)
                self.image = image
         }
    }
    
    public func downLoadImageOld(from url :String) {
        
       NetworkManager.shared.downloadImage(from: url){
           [weak self ] image  in
           guard let self = self else { return }
           DispatchQueue.main .async {
               self.image = image
           }
       }
   }
}
