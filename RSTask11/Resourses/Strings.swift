//
//  Strings.swift
//  RSTask11
//
//  Created by Ivan Budovich on 9/10/21.
//

import Foundation

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
}
