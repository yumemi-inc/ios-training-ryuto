//
//  YumemiWeatherSampleData.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/20.
//

import Foundation
@testable import iOS_Training_Ryuto

struct YumemiWeatherSampleData {
    static let sampleData = Weather(condition: .sunny, date: Date(), maxTemperature: 35, minTemperature: 15)
}
