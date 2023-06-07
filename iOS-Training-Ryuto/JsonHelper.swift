//
//  JsonHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

final class JsonHelper {
    static func createJSON(_ object: [String: String]) throws -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: object)
            guard let jsonString = String(bytes: jsonData, encoding: .utf8) else { return "" }
            return jsonString
        } catch {
            throw error
        }   
    }
}
