//
//  WeatherViewUITest.swift
//  iOS-Training-RyutoUITests
//
//  Created by 岩本 竜斗 on 2023/06/20.
//

import XCTest
@testable import iOS_Training_Ryuto

final class WeatherViewUITest: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func testWeatherImage() {
        let prefectureListView = PrefectureListViewPage(application: app)
        let weatherView = prefectureListView.goWeatherView()

        weatherView.reloadScreenWithoutError()

        switch weatherView.conditionTextLabel {
        case "晴れ":
            XCTAssertEqual(weatherView.conditionImageLabel, "Brightness Higher")
        case "曇り":
            XCTAssertEqual(weatherView.conditionImageLabel, "Mostly Cloudy")
        case "雨":
            XCTAssertEqual(weatherView.conditionImageLabel, "Rain")
        default:
            XCTFail()
        }
    }
    
    func testErrorAlert() {
        let prefectureListView = PrefectureListViewPage(application: app)
        let weatherView = prefectureListView.goWeatherView()
        
        weatherView.reloadScreenUntillError()
        
        XCTAssertTrue(weatherView.existsAlertButton)
    }
}
