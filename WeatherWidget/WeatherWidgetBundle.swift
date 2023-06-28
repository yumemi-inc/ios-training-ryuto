//
//  WeatherWidgetBundle.swift
//  WeatherWidget
//
//  Created by 岩本 竜斗 on 2023/06/27.
//

import WidgetKit
import SwiftUI

@main
struct WeatherWidgetBundle: WidgetBundle {
    var body: some Widget {
        WeatherWidget()
        WeatherWidgetLiveActivity()
    }
}
