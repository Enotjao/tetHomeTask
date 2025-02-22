//
//  CountryViewModel.swift
//  TetHomeTask
//

import Foundation

class CountriesViewModel: ObservableObject {
    @Published var countries: [Country]
    
    init(countries: [Country]) {
        self.countries = countries
        
    }
    
    func updateCountries(_ newCountries: [Country]) {
        self.countries = newCountries
        calculatePopulationRanks()
        countries.sort { $0.name.common < $1.name.common }
    }
    
    func addToFavorites(country: Country) {
        if let index = countries.firstIndex(where: { $0.id == country.id }) {
            if countries[index].isFavorite == nil {
                countries[index].isFavorite = true
            } else {
                countries[index].isFavorite?.toggle()
            }
        }
        objectWillChange.send()
    }
    
    private func calculatePopulationRanks()  {
        let sortedCountries = countries.sorted(by: { $0.population > $1.population })
        
        for (index, sortedCountry) in sortedCountries.enumerated() {
            if let originalIndex = countries.firstIndex(where: { $0.id == sortedCountry.id }) {
                countries[originalIndex].globalPopulationRank = index + 1
            }
        }
    }
}
