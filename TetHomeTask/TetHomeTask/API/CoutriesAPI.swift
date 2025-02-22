//
//  RequestManager.swift
//  TetHomeTask
//

import Foundation

class CoutriesAPI {
    static let baseURL = "https://restcountries.com/v3.1"
    
    class func getCountries() async throws -> [Country] {
        guard let url = URL(string: "\(baseURL)/all") else {
            throw URLError(.unsupportedURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        var countries = [Country]()
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Any] ?? []
            for part in json {
                if let partData = try? JSONSerialization.data(withJSONObject: part, options: []),
                   let country = try? JSONDecoder().decode(Country.self, from: partData) {
                    countries.append(country)
                }
            }
            return countries
        } catch let decodingError as DecodingError {
            switch decodingError {
            case .dataCorrupted(let context):
                debugPrint("Data corrupted: \(context.debugDescription)")
            case .keyNotFound(let key, let context):
                debugPrint("Key '\(key)' not found: \(context.debugDescription)")
            case .typeMismatch(let type, let context):
                debugPrint("Type '\(type)' mismatch: \(context.debugDescription)")
            case .valueNotFound(let type, let context):
                debugPrint("Value '\(type)' not found: \(context.debugDescription)")
            @unknown default:
                debugPrint("Unknown decoding error")
            }
        }
        return countries
    }
}
