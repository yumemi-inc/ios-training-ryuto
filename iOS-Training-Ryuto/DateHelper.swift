//
//  DateHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/09.
//

import Foundation

final class DateHelper {
    private let iso8601DateFormatter: ISO8601DateFormatter
    static let shared = DateHelper()
    
    private init() {
        self.iso8601DateFormatter = ISO8601DateFormatter()
        self.iso8601DateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
    }
}
