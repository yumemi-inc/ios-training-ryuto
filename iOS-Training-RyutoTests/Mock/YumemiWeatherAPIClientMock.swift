//
//  YumemiWeatherAPIClientMock.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/16.
//

import Foundation
import Combine
import YumemiWeather
@testable import iOS_Training_Ryuto

final class YumemiWeatherAPIClientMock: YumemiWeatherAPIClientProtocol {
    let weather: Weather?
    let yumemiWeatherError: YumemiWeatherError?
    
    init(weather: Weather? = nil, yumemiWeatherError: YumemiWeatherError? = nil) {
        self.weather = weather
        self.yumemiWeatherError = yumemiWeatherError
    }
    
    func fetchWeatherCondition(jsonString: String) throws -> Weather? {
        if let error = yumemiWeatherError {
            throw error
        }
        return weather
    }
    
    func asyncFetchWeather(jsonString: String) async throws -> Weather? {
        if let error = yumemiWeatherError {
            throw error
        }
        return weather
    }
}

