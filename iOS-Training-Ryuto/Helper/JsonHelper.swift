//
//  JsonHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

final class JsonHelper {
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder
    
    static let shared = JsonHelper()
    
    private init() {
        self.encoder = JSONEncoder()
        self.encoder.dateEncodingStrategy = .iso8601
        
        self.decoder = JSONDecoder()
        self.decoder.dateDecodingStrategy = .iso8601
    }
    
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
