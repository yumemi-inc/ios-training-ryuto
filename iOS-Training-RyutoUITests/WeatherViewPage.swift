//
//  WeatherViewPage.swift
//  iOS-Training-RyutoUITests
//
//  Created by 岩本 竜斗 on 2023/06/21.
//

import Foundation
import XCTest

final class WeatherViewPage: PageObject {
    
    enum IDs {
        static let prefectureText = "weather_prefecture_name"
        static let conditionImage = "weather_condition_image"
        static let conditionText = "weather_condition_text"
        static let alertButton = "weather_alert_button"
        static let reloadButton = "weather_reload_button"
    }
    
    private let app: XCUIApplication
    required init(application: XCUIApplication) {
        self.app = application
    }
    
    var prefectureText: XCUIElement {
        return app.staticTexts[IDs.prefectureText]
    }
    
    var conditionText: XCUIElement {
        return app.staticTexts[IDs.conditionText]
    }
    
    var conditionImage: XCUIElement {
        return app.images[IDs.conditionImage]
    }
    
    var alertButton: XCUIElement {
        return app.buttons[IDs.alertButton]
    }
    
    var reloadButton :XCUIElement {
        return app.buttons[IDs.reloadButton]
    }
}

extension WeatherViewPage {
    var existsPage: Bool { true }
    var existsPrefectureText: Bool { prefectureText.exists }
    var existsConditionText: Bool { conditionText.exists }
    var existsConditionImage: Bool { conditionImage.exists }
    var existsAlertButton: Bool { alertButton.exists }
    var existsReloadButton: Bool { reloadButton.exists }
}
