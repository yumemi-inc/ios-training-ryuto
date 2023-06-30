//
//  YumemiWeatherAPIClient.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import Combine
import YumemiWeather

protocol YumemiWeatherAPIClientDelegate: AnyObject {
    func weatherFetchDidComplete(with result: Result<Weather?, Error>)
}

protocol YumemiWeatherAPIClientProtocol {
    var delegate: YumemiWeatherAPIClientDelegate? { get set }
    func fetchWeatherCondition(jsonString: String)
    func asyncFetchWeather(jsonString: String) async
}

final class YumemiWeatherAPIClient: YumemiWeatherAPIClientProtocol {
    weak var delegate: YumemiWeatherAPIClientDelegate?
    
    func fetchWeatherCondition(jsonString: String) {
        do {
            let response = try YumemiWeather.fetchWeather(jsonString)
            guard let responseData = response.data(using: .utf8) else {
                delegate?.weatherFetchDidComplete(with: .success(nil))
                return
            }
            let weather = try JSONHelper.decode(Weather.self, data: responseData)
            delegate?.weatherFetchDidComplete(with: .success(weather))
        } catch {
            delegate?.weatherFetchDidComplete(with: .failure(error))
        }
    }
    
    func asyncFetchWeather(jsonString: String) async {
        do {
            let response = try await YumemiWeather.asyncFetchWeather(jsonString)
            guard let responseData = response.data(using: .utf8) else {
                delegate?.weatherFetchDidComplete(with: .success(nil))
                return
            }
            let weather = try JSONHelper.decode(Weather.self, data: responseData)
            delegate?.weatherFetchDidComplete(with: .success(weather))
        } catch {
            delegate?.weatherFetchDidComplete(with: .failure(error))
        }
    }
}

#if DEBUG
final class YumemiWeatherAPIClientMock: YumemiWeatherAPIClientProtocol {
    weak var delegate: YumemiWeatherAPIClientDelegate?
    
    let weather: Weather?
    let yumemiWeatherError: YumemiWeatherError?
    
    init(weather: Weather? = nil, yumemiWeatherError: YumemiWeatherError? = nil) {
        self.weather = weather
        self.yumemiWeatherError = yumemiWeatherError
    }
    
    func fetchWeatherCondition(jsonString: String) {
        if let yumemiWeatherError = yumemiWeatherError {
            delegate?.weatherFetchDidComplete(with: .failure(yumemiWeatherError))
        }
        delegate?.weatherFetchDidComplete(with: .success(weather))
    }
    
    func asyncFetchWeather(jsonString: String) async {
        if let yumemiWeatherError = yumemiWeatherError {
            delegate?.weatherFetchDidComplete(with: .failure(yumemiWeatherError))
        }
        delegate?.weatherFetchDidComplete(with: .success(weather))
    }
}
#endif
