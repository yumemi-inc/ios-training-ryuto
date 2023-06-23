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
    }
    
    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
    
    func testWeatherImage() {
        app.launchArguments = ["WeatherViewUITest_Valid"]
        app.launch()
        
        let prefectureListView = PrefectureListViewPage(application: app)
        let weatherView = prefectureListView.goWeatherView()
        
        switch weatherView.conditionTextLabel {
        case "晴れ":
            XCTAssertEqual(weatherView.conditionImageLabel, "Brightness Higher")
        default:
            XCTFail()
        }
    }
    
    func testErrorAlert() {
        app.launchArguments = ["WeatherViewUITest_Error"]
        app.launch()
        
        let prefectureListView = PrefectureListViewPage(application: app)
        let weatherView = prefectureListView.goWeatherView()
        
        XCTAssertTrue(weatherView.existsAlertButton)
    }
}
