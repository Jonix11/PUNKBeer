//
//  DateFormatter+Custom.swift
//  Punk Beer
//
//  Created by Jon Gonzalez on 22/2/21.
//

import Foundation

extension DateFormatter {
    static let beerAPIDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/yyyy"
        return formatter
    }()
}
