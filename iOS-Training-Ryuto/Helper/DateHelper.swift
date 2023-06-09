//
//  DateHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/09.
//

import Foundation

final class DateHelper {
    private let dateFormatter: DateFormatter
    static let shared = DateHelper()
    
    private init() {
        self.dateFormatter          = DateFormatter()
        self.dateFormatter.calendar = Calendar(identifier: .gregorian)
        self.dateFormatter.locale   = Locale(identifier: "jp_JP")
    }
}

extension DateHelper {
    func formatToString(date: Date, dateFormat: String) -> String {
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
}
