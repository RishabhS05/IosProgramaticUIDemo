//
//  Uihelper.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 08/08/24.
//

import UIKit

enum Uihelper {
    
    static func create3columnFlowLayput(in view : UIView ) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding  : CGFloat = 12
        let mininumItemSpace : CGFloat = 10
        let availableWidth = width - (padding * 2) - (mininumItemSpace * 2)
        let itemwidth = availableWidth / 3
        let flowLayout  = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize  = CGSize(width: itemwidth, height: itemwidth + 40 )
        return flowLayout
    }
}
