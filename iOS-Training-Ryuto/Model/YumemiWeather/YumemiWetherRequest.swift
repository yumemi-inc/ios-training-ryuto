//
//  YumemiWetherRequest.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/09.
//

import Foundation

struct YumemiWeatherRequest: Encodable {
    let area: String
    let date: Date
}
