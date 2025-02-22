//
//  FlagsAPI.swift
//  TetHomeTask
//

import Foundation

class FlagsApi {
    static let baseURL = "https://flagsapi.com";

    class func getCountryFlagImageUrl(countryCode: String) -> String {
        return "\(baseURL)/\(countryCode)/flat/64.png";
    }
}
