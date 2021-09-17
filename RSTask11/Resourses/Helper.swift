//
//  Strings.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation
import UIKit

enum Strings {
    enum TabBar {
        static let rocket: String = "Rockets"
        static let launch: String = "Launches"
        static let launchpad: String = "Launchpads"
    }
}

extension String {
    var toDateFormat: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else {return self}
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "MMMM d, yyyy"
        return printFormatter.string(from: date)
    
    }
    
    var fromExtendedFormatToDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        guard let date = dateFormatter.date(from: self) else {return self}
        let printFormatter = DateFormatter()
        printFormatter.dateFormat = "MMMM d, yyyy"
        return printFormatter.string(from: date)
    }
    
    static func compareExtendedDates(date1: String?, date2: String?) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'.000Z'"
        guard let date1 = date1, let firstDate = dateFormatter.date(from: date1) else { return false }
        guard let date2 = date2, let secondDate = dateFormatter.date(from: date2) else { return true }
        return firstDate > secondDate
    }
    
    static func compareDates(date1: String, date2: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let firstDate = dateFormatter.date(from: date1) else { return false }
        guard let secondDate = dateFormatter.date(from: date2) else { return true }
        return firstDate > secondDate
    }
}

extension UIDevice {
    static var isSEorTouch: Bool{
        return UIScreen.main.bounds.height <= 568
    }
    
    static var is678: Bool {
        return UIScreen.main.bounds.height <= 667
    }
}
