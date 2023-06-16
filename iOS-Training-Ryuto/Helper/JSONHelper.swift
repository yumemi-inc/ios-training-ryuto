//
//  JsonHelper.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/07.
//

import Foundation

final class JSONHelper {
    private static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()
}

extension JSONHelper {
    static func encodeToString<T: Encodable>(_ model: T) throws -> String? {
        do {
            let jsonData = try JSONHelper.encoder.encode(model)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            throw error
        }
    }
    
    static func decode<T: Decodable>(_ model: T.Type, data: Data) throws -> T {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            return try decoder.decode(model, from: data)
        } catch {
            throw error
        }
    }
}
