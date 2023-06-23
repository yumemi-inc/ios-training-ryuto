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
    @Published var yumemiWeatherError: YumemiWeatherError? = nil
    
    private let yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol
    
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
    
    func asyncFetchWeather(area: String, date: Date) async {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        do {
            weather = try await yumemiWeatherAPIClient.asyncFetchWeather(jsonString: jsonString)
        } catch {
            if let error = error as? YumemiWeatherError {
                yumemiWeatherError = error
            }
        }
    }
}
