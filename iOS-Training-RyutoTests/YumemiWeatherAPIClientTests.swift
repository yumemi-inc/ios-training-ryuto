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
    
    func testFetchWeatherCondition_ValidJSON() {
        
        let jsonString = """
            {
                "area": "tokyo",
                "date": "2023-06-16T12:00:00+09:00"
            }
            """
        let expectation = self.expectation(description: "非同期処理")
        
        client.weather
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .success(let weather):
                    self?.weather = weather
                case .failure(let error):
                    self?.error = error
                }
                
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        
        client.fetchWeatherCondition(jsonString: jsonString)
        
        wait(for: [expectation], timeout: 10)
        
        if let weather = weather {
            XCTAssertTrue(true)
        } else {
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .unknownError)
        }
    }
    
    func testFetchWeatherCondition_InvalidJSON() {
        
        let jsonString = """
                {
                    "area": tokyo,
                }
                """
        let expectation = self.expectation(description: "非同期処理")
        
        client.weather
            .sink(receiveValue: { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.error = error
                default:
                    break
                }
                
                expectation.fulfill()
            })
            .store(in: &subscriptions)
        
        client.fetchWeatherCondition(jsonString: jsonString)
        
        wait(for: [expectation], timeout: 10)
        
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .invalidParameterError)
        
    }
}
