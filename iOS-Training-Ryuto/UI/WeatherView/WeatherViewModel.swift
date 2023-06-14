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
            .compactMap { result in
                switch result {
                case .success(let weather):
                    return weather
                default:
                    return nil
                }
            }
            .assign(to: \.weather, on: self)
            .store(in: &apiSubscriptions)
    }
    
    func fetchWeatherCondition(area: String, date: Date) {
        let request = YumemiWeatherRequest(area: area, date: date)
        guard let jsonString = try? JSONHelper.encodeToString(request) else { return }
        yumemiWeatherAPIClient.fetchWeatherCondition(jsonString: jsonString)
    }

}
