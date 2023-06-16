//
//  YumemiWeatherAPIClientTests.swift
//  iOS-Training-RyutoTests
//
//  Created by 岩本 竜斗 on 2023/06/16.
//

import XCTest
@testable import iOS_Training_Ryuto

final class YumemiWeatherAPIClientTests: XCTestCase {
    var client: YumemiWeatherAPIClient!
    
    override func setUp() {
        client = YumemiWeatherAPIClient()
    }
}
