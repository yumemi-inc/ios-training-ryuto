//
//  PageObject.swift
//  iOS-Training-RyutoUITests
//
//  Created by 岩本 竜斗 on 2023/06/21.
//

import Foundation
import XCTest

protocol PageObject: PageObjectAssertion {
    init(application: XCUIApplication)
}

protocol PageObjectAssertion {
    var existsPage: Bool { get }
}
