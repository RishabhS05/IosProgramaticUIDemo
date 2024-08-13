//
//  Date+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import Foundation

extension Date{

    func convertToMonthYear () -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM yyyy"
        return dateFormater.string(from: self)
    }
    
    func convertWithDefaultToMonthYear() -> String {
        return formatted(.dateTime.month(.wide).year())
    }
}
