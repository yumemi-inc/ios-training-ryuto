//
//  WeatherViewModelTest.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/20.
//

import XCTest
import YumemiWeather
@testable import iOS_Training_Ryuto

final class WeatherViewModelTest: XCTestCase {
    var viewModel: WeatherViewModel!
    
    func testFetchWeatherCondition() {
        XCTContext.runActivity(named: "正常") { _ in
            viewModel = WeatherViewModel(yumemiWeatherAPIClient: YumemiWeatherAPIClientMock())
            viewModel.fetchWeatherCondition(area: "東京", date: Date())
            
            XCTAssertNil(viewModel.yumemiWeatherError)
            XCTAssertEqual(viewModel.weather?.condition, YumemiWeatherSampleData.sampleData.condition)
            XCTAssertEqual(viewModel.weather?.maxTemperature, YumemiWeatherSampleData.sampleData.maxTemperature)
            XCTAssertEqual(viewModel.weather?.minTemperature, YumemiWeatherSampleData.sampleData.minTemperature)
        }
        
        XCTContext.runActivity(named: "エラー") { _ in
            viewModel = WeatherViewModel(yumemiWeatherAPIClient: YumemiWeatherAPIClientMock(yumemiWeatherError: .unknownError))
            viewModel.fetchWeatherCondition(area: "東京", date: Date())
            
            XCTAssertNil(viewModel.weather)
            XCTAssertEqual(viewModel.yumemiWeatherError, .unknownError)
        }
    }
}
