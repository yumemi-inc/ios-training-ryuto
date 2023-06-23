//
//  YumemiWeatherAPIClient.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import Combine
import YumemiWeather

protocol YumemiWeatherAPIClientDelegate {
    func weatherFetchDidComplete(with result: Result<Weather?, Error>)
}

protocol YumemiWeatherAPIClientProtocol {
    func fetchWeatherCondition(jsonString: String) throws -> Weather?
    func asyncFetchWeather(jsonString: String) async throws -> Weather?
}

final class YumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol {
    func fetchWeatherCondition(jsonString: String) throws -> Weather? {
        let response = try YumemiWeather.fetchWeather(jsonString)
        guard let responseData = response.data(using: .utf8) else { return nil }
        return try JSONHelper.decode(Weather.self, data: responseData)
    }
    
    func asyncFetchWeather(jsonString: String) async throws -> Weather? {
        let response = try await YumemiWeather.asyncFetchWeather(jsonString)
        guard let responseData = response.data(using: .utf8) else { return nil }
        return try JSONHelper.decode(Weather.self, data: responseData)
    }
}

#if DEBUG
final class YumemiWeatherAPIClientMock: YumemiWeatherAPIClientProtocol {
    let weather: Weather?
    let yumemiWeatherError: YumemiWeatherError?
    
    init(weather: Weather? = nil, yumemiWeatherError: YumemiWeatherError? = nil) {
        self.weather = weather
        self.yumemiWeatherError = yumemiWeatherError
    }
    
    func fetchWeatherCondition(jsonString: String) throws -> Weather? {
        if let yumemiWeatherError = yumemiWeatherError {
            throw yumemiWeatherError
        }
        return weather
    }
    
    func asyncFetchWeather(jsonString: String) async throws -> Weather? {
        if let yumemiWeatherError = yumemiWeatherError {
            throw yumemiWeatherError
        }
        return weather
    }
}
#endif
