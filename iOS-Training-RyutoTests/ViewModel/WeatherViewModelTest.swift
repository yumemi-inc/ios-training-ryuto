//
//  WeatherViewModelTest.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/20.
//

import XCTest
import YumemiWeather
@testable import iOS_Training_Ryuto

@MainActor
final class WeatherViewModelTest: XCTestCase {
    var viewModel: WeatherViewModel!
    
    func testFetchWeatherCondition_Valid() {
        viewModel = WeatherViewModel(yumemiWeatherAPIClient: YumemiWeatherAPIClientMock(weather: YumemiWeatherSampleData.sampleData))
        let expectation = XCTestExpectation(description: "非同期処理")
        
        viewModel.fetchWeatherCondition(area: "東京", date: Date())
        
        Task { @MainActor in
            XCTAssertNil(viewModel.yumemiWeatherError)
            XCTAssertEqual(viewModel.weather?.condition, YumemiWeatherSampleData.sampleData.condition)
            XCTAssertEqual(viewModel.weather?.maxTemperature, YumemiWeatherSampleData.sampleData.maxTemperature)
            XCTAssertEqual(viewModel.weather?.minTemperature, YumemiWeatherSampleData.sampleData.minTemperature)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFetchWeatherCondition_Error() {
        viewModel = WeatherViewModel(yumemiWeatherAPIClient: YumemiWeatherAPIClientMock(yumemiWeatherError: .unknownError))
        let expectation = XCTestExpectation(description: "非同期処理")
        
        viewModel.fetchWeatherCondition(area: "東京", date: Date())
        
        Task { @MainActor in
            XCTAssertNil(viewModel.weather)
            XCTAssertEqual(viewModel.yumemiWeatherError, .unknownError)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testAsyncFetchWeather_Valid() async {
        viewModel = WeatherViewModel(yumemiWeatherAPIClient: YumemiWeatherAPIClientMock(weather: YumemiWeatherSampleData.sampleData))
        let expectation = XCTestExpectation(description: "非同期処理")
        
        await viewModel.asyncFetchWeather(area: "東京", date: Date())
        
        Task { @MainActor in
            XCTAssertNil(viewModel.yumemiWeatherError)
            XCTAssertEqual(viewModel.weather?.condition, YumemiWeatherSampleData.sampleData.condition)
            XCTAssertEqual(viewModel.weather?.maxTemperature, YumemiWeatherSampleData.sampleData.maxTemperature)
            XCTAssertEqual(viewModel.weather?.minTemperature, YumemiWeatherSampleData.sampleData.minTemperature)
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testAsyncFetchWeather_Error() async {
        viewModel = WeatherViewModel(yumemiWeatherAPIClient: YumemiWeatherAPIClientMock(yumemiWeatherError: .unknownError))
        let expectation = XCTestExpectation(description: "非同期処理")
        
        await viewModel.asyncFetchWeather(area: "東京", date: Date())
        
        Task { @MainActor in
            XCTAssertNil(viewModel.weather)
            XCTAssertEqual(viewModel.yumemiWeatherError, .unknownError)
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
}
