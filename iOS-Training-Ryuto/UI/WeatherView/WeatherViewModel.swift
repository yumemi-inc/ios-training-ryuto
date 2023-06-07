//
//  WeatherViewModel.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

final class WeatherViewModel: ObservableObject {
    @Published private(set) var weather: Weather? = nil
}
