//
//  Name.swift
//  TetHomeTask
//

import Foundation

struct Name: Codable, Equatable, Hashable, Comparable {
    let common: String
    let official: String
    
    static func < (lhs: Name, rhs: Name) -> Bool {
        return lhs.common == rhs.common
        && lhs.official == rhs.official
    }
}
