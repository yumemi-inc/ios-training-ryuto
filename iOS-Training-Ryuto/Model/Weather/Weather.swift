//
//  Weather.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

struct Weather: Decodable {
    let condition: WeatherCondition
    let date: Date
    let maxTemperature: Int
    let minTemperature: Int
    
    enum CodingKeys: String, CodingKey {
        case condition = "weather_condition"
        case date
        case maxTemperature = "max_temperature"
        case minTemperature = "min_temperature"
    }
}
