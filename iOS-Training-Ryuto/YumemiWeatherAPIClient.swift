//
//  YumemiWeatherAPIClient.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import Combine
import YumemiWeather

protocol YumemiWeatherAPIClientProtocol {
    var weather: PassthroughSubject<Weather, Never> { get set }
    
    func fetchWeatherCondition(jsonString: String)
}

final class YumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol {
    var weather = PassthroughSubject<Weather, Never>()
    
    func fetchWeatherCondition(jsonString: String) {
        do {
            let response = try YumemiWeather.fetchWeather(jsonString)
            guard let responseData = response.data(using: .utf8) else { return }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601 // Date型にデコードできるように指定
            let weather = try decoder.decode(Weather.self, from: responseData)
            self.weather.send(weather)
        } catch {
            print(error)
        }
    }
    
}
