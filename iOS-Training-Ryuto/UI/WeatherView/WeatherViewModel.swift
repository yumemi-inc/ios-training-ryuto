//
//  WeatherViewModel.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather? = nil
    
    private let yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol
    
    init(yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol = YumemiWeatherAPIClient()) {
        self.yumemiWeatherAPIClient = yumemiWeatherAPIClient
    }
    
    func fetchWeatherCondition(area: String, date: Date) {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        weather = try? yumemiWeatherAPIClient.fetchWeatherCondition(jsonString: jsonString)
    }

}
