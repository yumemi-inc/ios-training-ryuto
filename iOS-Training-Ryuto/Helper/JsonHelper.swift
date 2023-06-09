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
}

extension JsonHelper {
    func encodeToString<T: Encodable>(_ model: T) throws -> String? {
        do {
            let jsonData = try encoder.encode(model)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            throw error
        }
    }
    
    func decode<T: Decodable>(_ model: T.Type, data: Data) throws -> T {
        do {
            return try decoder.decode(model, from: data)
        } catch {
            throw error
        }
    }
}
