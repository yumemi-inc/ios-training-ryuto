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
    var weather: Weather?
    var error: YumemiWeatherError?
    
    override func setUp() {
        client = YumemiWeatherAPIClient()
        client.delegate = self
    }
    
    func testFetchWeatherCondition_ValidJSON() {
        let jsonString = """
            {
                "area": "tokyo",
                "date": "2023-06-16T12:00:00+09:00"
            }
            """
        
        let expectation = XCTestExpectation(description: "非同期処理")
        
        client.fetchWeatherCondition(jsonString: jsonString)
        
        Task { @MainActor in
            if let weather = weather {
                XCTAssertTrue(true)
            } else {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .unknownError)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testFetchWeatherCondition_InvalidJSON() {
        let jsonString = """
            {
                "area": tokyo,
            }
            """
        let expectation = XCTestExpectation(description: "非同期処理")

        client.fetchWeatherCondition(jsonString: jsonString)
        
        Task { @MainActor in
            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .invalidParameterError)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testAsyncFetchWeather_ValidJSON() async {
        let jsonString = """
            {
                "area": "tokyo",
                "date": "2023-06-16T12:00:00+09:00"
            }
            """
        
        let expectation = XCTestExpectation(description: "非同期処理")
        
        await client.asyncFetchWeather(jsonString: jsonString)
        
        Task { @MainActor in
            if let weather = weather {
                XCTAssertTrue(true)
            } else {
                XCTAssertNotNil(error)
                XCTAssertEqual(error, .unknownError)
            }
            
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
    
    func testAsyncFetchWeather_InvalidJSON() async {
        let jsonString = """
            {
                "area": tokyo,
            }
            """
        
        let expectation = XCTestExpectation(description: "非同期処理")
        
        await client.asyncFetchWeather(jsonString: jsonString)
        
        Task { @MainActor in
            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .invalidParameterError)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5.0)
    }
}

extension YumemiWeatherAPIClientTests: YumemiWeatherAPIClientDelegate {
    func weatherFetchDidComplete(with result: Result<Weather?, Error>) {
        switch result {
        case .success(let weather):
            self.weather = weather
        case .failure(let error):
            if let error = error as? YumemiWeatherError {
                self.error = error
            }
        }
    }
}
