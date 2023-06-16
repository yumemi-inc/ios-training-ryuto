//
//  YumemiWeatherAPIClientMock.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/16.
//

import Foundation
import Combine
import YumemiWeather
@testable import iOS_Training_Ryuto

final class YumemiWeatherAPIClientMock {
    let yumemiWeatherError: YumemiWeatherError?
    
    init(yumemiWeatherError: YumemiWeatherError? = nil) {
        self.yumemiWeatherError = yumemiWeatherError
    }
}
