//
//  String+ext.swift
//  GithubProjectTutorial
//
//  Created by Rishabh Shrivastava on 10/08/24.
//

import Foundation

extension String {
        //decodingStragy will do for us decoder.dateformaterStrategy
    func convertToDate() -> Date? {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormater.locale = Locale(identifier : "en_IN")
        dateFormater.timeZone = .current
        return dateFormater.date(from: self)
    }
    
    func convertToDisplayFormat () -> String {
        guard let date = self.convertToDate() else { return "" }
        return date.convertToMonthYear()
    }
     
}
