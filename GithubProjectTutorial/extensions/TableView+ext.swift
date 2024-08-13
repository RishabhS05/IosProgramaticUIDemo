//
//  TableView+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 12/08/24.
//

import UIKit

extension UITableView {
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
    
    func updateTableViewOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
