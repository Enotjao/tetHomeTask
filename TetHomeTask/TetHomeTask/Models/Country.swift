//
//  CountriesResponse.swift
//  TetHomeTask
//

import Foundation

class Country: Codable, Identifiable, Hashable, Equatable, ObservableObject {
    let id = UUID()
    let name: Name
    let cca2, cca3: String
    var capital: [String]? = []
    var languages: [String: String]? = [:]
    let translations: [String: Translation]
    var latlng: [Double]? = []
    let area: Int
    let flag: String
    let population: Int
    let capitalInfo: CapitalInfo
    var borders: [String]? = []
    var globalPopulationRank = 0
    
    @Published var isFavorite: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case cca2
        case cca3
        case capital
        case languages
        case translations
        case latlng
        case area
        case flag
        case population
        case capitalInfo
        case borders
        case isFavorite
        case globalPopulationRank
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(Name.self, forKey: .name)
        self.cca2 = try container.decode(String.self, forKey: .cca2)
        self.cca3 = try container.decode(String.self, forKey: .cca3)
        self.capital = try container.decodeIfPresent([String].self, forKey: .capital)
        self.languages = try container.decodeIfPresent([String: String].self, forKey: .languages)
        self.translations = try container.decode([String: Translation].self, forKey: .translations)
        self.latlng = try container.decodeIfPresent([Double].self, forKey: .latlng)
        self.area = try container.decode(Int.self, forKey: .area)
        self.flag = try container.decode(String.self, forKey: .flag)
        self.population = try container.decode(Int.self, forKey: .population)
        self.capitalInfo = try container.decode(CapitalInfo.self, forKey: .capitalInfo)
        self.borders = try container.decodeIfPresent([String].self, forKey: .borders)
        self.isFavorite = isFavorite
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(cca2, forKey: .cca2)
        try container.encode(cca3, forKey: .cca3)
        try container.encodeIfPresent(capital, forKey: .capital)
        try container.encodeIfPresent(languages, forKey: .languages)
        try container.encode(translations, forKey: .translations)
        try container.encodeIfPresent(latlng, forKey: .latlng)
        try container.encode(area, forKey: .area)
        try container.encode(flag, forKey: .flag)
        try container.encode(population, forKey: .population)
        try container.encode(capitalInfo, forKey: .capitalInfo)
        try container.encodeIfPresent(borders, forKey: .borders)
        try container.encode(isFavorite, forKey: .isFavorite)
        try container.encode(globalPopulationRank, forKey: .globalPopulationRank)
    }
    
    static func == (lhs: Country, rhs: Country) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.cca2 == rhs.cca2 &&
        lhs.cca3 == rhs.cca3 &&
        lhs.capital == rhs.capital &&
        lhs.languages == rhs.languages &&
        lhs.translations == rhs.translations &&
        lhs.latlng == rhs.latlng &&
        lhs.area == rhs.area &&
        lhs.flag == rhs.flag &&
        lhs.population == rhs.population &&
        lhs.capitalInfo == rhs.capitalInfo &&
        lhs.borders == rhs.borders &&
        lhs.isFavorite == rhs.isFavorite &&
        lhs.globalPopulationRank == rhs.globalPopulationRank
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(cca2)
        hasher.combine(cca3)
        hasher.combine(capital)
        hasher.combine(languages)
        hasher.combine(translations)
        hasher.combine(latlng)
        hasher.combine(area)
        hasher.combine(flag)
        hasher.combine(population)
        hasher.combine(capitalInfo)
        hasher.combine(borders)
        hasher.combine(isFavorite)
        hasher.combine(globalPopulationRank)
    }
}
