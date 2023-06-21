//
//  PrefectureListViewPage.swift
//  iOS-Training-RyutoUITests
//
//  Created by 岩本 竜斗 on 2023/06/21.
//

import Foundation
import XCTest

final class PrefectureListViewPage: PageObject {
    private let app: XCUIApplication
    required init(application: XCUIApplication) {
        self.app = application
    }
}

extension PrefectureListViewPage {
    var existsPage: Bool { true }
}
