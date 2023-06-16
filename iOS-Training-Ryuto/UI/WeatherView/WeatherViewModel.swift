//
//  WeatherViewModel.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import Combine
import YumemiWeather

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather? = nil
    @Published var yumemiWeatherError: YumemiWeatherError? = nil
    
    private var apiSubscriptions: Set<AnyCancellable> = .init()
    private let yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol
    
    init(yumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol = YumemiWeatherAPIClient()) {
        self.yumemiWeatherAPIClient = yumemiWeatherAPIClient
        
        yumemiWeatherAPIClient.weather
            .compactMap { result in
                guard case let .success(weather) = result else { return nil }
                return weather
            }
            .assign(to: \.weather, on: self)
            .store(in: &apiSubscriptions)
        
        yumemiWeatherAPIClient.weather
            .compactMap { result in
                guard case let .failure(error) = result else { return nil }
                return error
            }
            .assign(to: \.yumemiWeatherError, on: self)
            .store(in: &apiSubscriptions)
    }
    
    func fetchWeatherCondition(area: String, date: Date) {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        yumemiWeatherAPIClient.fetchWeatherCondition(jsonString: jsonString)
    }

}
