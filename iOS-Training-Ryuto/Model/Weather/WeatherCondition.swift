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
    
    init(condition: String) {
        switch condition {
        case "sunny" : self = .sunny
        case "cloudy": self = .cloudy
        case "rainy" : self = .rainy
        default      : self = .sunny
        }
    }
    
    var rawValue: String {
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