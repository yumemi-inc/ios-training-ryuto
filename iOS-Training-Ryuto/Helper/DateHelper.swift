//
//  DateHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/09.
//

import Foundation

final class DateHelper {
    private static let dateFormatter: DateFormatter = {
       let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.locale = Locale(identifier: "jp_JP")
        return dateFormatter
    }()
}

extension DateHelper {
    static func formatToString(date: Date, dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
