//
//  WeatherViewModel.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import Combine

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather? = nil
    
    private var apiSubscriptions: Set<AnyCancellable> = .init()
    private let yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol
    
    init(yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol = YumemiWeatherAPIClient()) {
        self.yumemiWeatherAPIClient = yumemiWeatherAPIClient
        
        yumemiWeatherAPIClient.weather
            .compactMap { $0 }
            .assign(to: \.weather, on: self)
            .store(in: &apiSubscriptions)
    }
    
    func fetchWeatherCondition(jsonString: String) {
        yumemiWeatherAPIClient.fetchWeatherCondition(jsonString: jsonString)
    }
}
