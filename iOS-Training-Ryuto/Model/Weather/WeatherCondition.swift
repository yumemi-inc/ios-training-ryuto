//
//  WeatherCondition.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

enum WeatherCondition: String, Decodable {
    case sunny
    case cloudy
    case rainy
    
    var localized: String {
        switch self {
        case .sunny:
            return "晴れ"
        case .cloudy:
            return "曇り"
        case .rainy:
            return "雨"
        }
    }
}
