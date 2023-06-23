//
//  PrefectureListViewPage.swift
//  iOS-Training-RyutoUITests
//
//  Created by 岩本 竜斗 on 2023/06/21.
//

import Foundation
import XCTest

final class PrefectureListViewPage: PageObject {
    
    enum IDs {
        static let prefectureList = "prefecture_list"
        static let prefectureListRow = "prefecture_list_row"
    }
    
    private let app: XCUIApplication
    required init(application: XCUIApplication) {
        self.app = application
    }
    
    private var prefectureList: XCUIElement {
        app.collectionViews[IDs.prefectureList]
    }
    
    private var prefectureListRow: XCUIElement {
        prefectureList.cells.element(boundBy: 1)
    }
    
    func goWeatherView() -> WeatherViewPage {
        prefectureListRow.tap()
        return WeatherViewPage(application: app)
    }
}
