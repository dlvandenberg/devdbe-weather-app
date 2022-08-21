//
//  DateExtensions.swift
//  WeatherApp
//
//  Created by Dennis van den Berg on 21/08/2022.
//

import Foundation

extension Date {
    func dayOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self).uppercased()
    }
}
