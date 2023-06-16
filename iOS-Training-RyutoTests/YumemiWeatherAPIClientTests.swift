//
//  YumemiWeatherAPIClientTests.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/16.
//

import XCTest
import Combine
import YumemiWeather
@testable import iOS_Training_Ryuto

final class YumemiWeatherAPIClientTests: XCTestCase {
    var client: YumemiWeatherAPIClient!
    var subscriptions: Set<AnyCancellable>!
    var weather: Weather?
    var error: YumemiWeatherError?
    
    override func setUp() {
        client = YumemiWeatherAPIClient()
        subscriptions = Set<AnyCancellable>()
    }
}
