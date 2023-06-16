//
//  YumemiWeatherError.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/16.
//

import Foundation
import YumemiWeather

extension YumemiWeatherError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidParameterError:
            return "無効なパラメータです"
        case .unknownError:
            return "不明なエラーです"
        }
    }
}
