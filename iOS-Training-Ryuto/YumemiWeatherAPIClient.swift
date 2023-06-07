//
//  YumemiWeatherAPIClient.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation
import Combine

protocol YumemiWeatherAPIClientProtocol {
    var weather: PassthroughSubject<Weather, Error> { get set }
    
    func fetchWeatherCondition(jsonString: String)
}

final class YumemiWeatherAPIClient {
    
}
