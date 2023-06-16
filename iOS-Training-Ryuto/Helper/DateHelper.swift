//
//  DateHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/09.
//

import Foundation

final class DateHelper {
    static func formatToString(date: Date, dateFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "jp_JP")
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
