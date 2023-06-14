//
//  WeatherViewModel.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import YumemiWeather

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather? = nil
    @Published private(set) var yumemiWeatherError: YumemiWeatherError? = nil
    
    private let yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol
    
    init(yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol = YumemiWeatherAPIClient()) {
        self.yumemiWeatherAPIClient = yumemiWeatherAPIClient
    }
    
    func fetchWeatherCondition(area: String, date: Date) {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        do {
            weather = try yumemiWeatherAPIClient.fetchWeatherCondition(jsonString: jsonString)
        } catch {
            if let error = error as? YumemiWeatherError {
                yumemiWeatherError = error
            }
        }
    }
}
