//
//  WeatherViewModel.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import YumemiWeather

@MainActor
final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather? = nil
    @Published private(set) var isLoading: Bool = false
    @Published var yumemiWeatherError: YumemiWeatherError? = nil
    
    private var yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol
    
    init(yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol = YumemiWeatherAPIClient()) {
        if ProcessInfo.processInfo.arguments.contains("WeatherViewUITest_Valid") {
            // UITest時にモックを渡す
            self.yumemiWeatherAPIClient = YumemiWeatherAPIClientMock(
                weather: Weather(condition: .sunny, date: Date(), maxTemperature: 30, minTemperature: 15)
            )
        } else if ProcessInfo.processInfo.arguments.contains("WeatherViewUITest_Error") {
            self.yumemiWeatherAPIClient = YumemiWeatherAPIClientMock(yumemiWeatherError: .unknownError)
        } else {
            self.yumemiWeatherAPIClient = yumemiWeatherAPIClient
        }
        
        self.yumemiWeatherAPIClient.delegate = self
    }
    
    func fetchWeatherCondition(area: String, date: Date) {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        yumemiWeatherAPIClient.fetchWeatherCondition(jsonString: jsonString)
    }
    
    func asyncFetchWeather(area: String, date: Date) async {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        
        isLoading = true
        await yumemiWeatherAPIClient.asyncFetchWeather(jsonString: jsonString)
        isLoading = false
    }
}

extension WeatherViewModel: YumemiWeatherAPIClientDelegate {
    func weatherFetchDidComplete(with result: Result<Weather?, Error>) {
        Task { @MainActor in
            switch result {
            case .success(let weather):
                self.weather = weather
                
            case .failure(let error):
                if let yumemiWeatherError = error as? YumemiWeatherError {
                    self.yumemiWeatherError = yumemiWeatherError
                }
            }
        }
    }
}
