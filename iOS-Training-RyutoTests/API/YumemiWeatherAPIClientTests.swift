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
    }
    
    func testFetchWeatherCondition_ValidJSON() {
        let jsonString = """
            {
                "area": "tokyo",
                "date": "2023-06-16T12:00:00+09:00"
            }
            """
        
        do {
            weather = try client.fetchWeatherCondition(jsonString: jsonString)
        } catch {
            if let error = error as? YumemiWeatherError {
                self.error = error
            }
        }
        
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
            
            do {
                weather = try client.fetchWeatherCondition(jsonString: jsonString)
            } catch {
                if let error = error as? YumemiWeatherError {
                    self.error = error
                }
            }

            XCTAssertNil(weather)
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .invalidParameterError)
    }
    
    func testAsyncFetchWeather_ValidJSON() async {
        let jsonString = """
            {
                "area": "tokyo",
                "date": "2023-06-16T12:00:00+09:00"
            }
            """
        
        do {
            weather = try await client.asyncFetchWeather(jsonString: jsonString)
        } catch {
            if let error = error as? YumemiWeatherError {
                self.error = error
            }
        }
        
        if let weather = weather {
            XCTAssertTrue(true)
        } else {
            XCTAssertNotNil(error)
            XCTAssertEqual(error, .unknownError)
        }
    }
    
    func testAsyncFetchWeather_InvalidJSON() async {
        let jsonString = """
            {
                "area": tokyo,
            }
            """
        
        do {
            weather = try await client.asyncFetchWeather(jsonString: jsonString)
        } catch {
            if let error = error as? YumemiWeatherError {
                self.error = error
            }
        }
        
        XCTAssertNil(weather)
        XCTAssertNotNil(error)
        XCTAssertEqual(error, .invalidParameterError)
        
    }
}

