//
//  DateHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/09.
//

import Foundation

final class DateHelper {
    private let dateFormatter: DateFormatter
    private let iso8601DateFormatter: ISO8601DateFormatter
    static let shared = DateHelper()
    
    private init() {
        self.iso8601DateFormatter = ISO8601DateFormatter()
        self.iso8601DateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        
        self.dateFormatter          = DateFormatter()
        self.dateFormatter.calendar = Calendar(identifier: .gregorian)
        self.dateFormatter.locale   = Locale(identifier: "jp_JP")
    }
}

extension DateHelper {
    func dateToISO8601String(date: Date) -> String {
        return iso8601DateFormatter.string(from: date)
    }
}
