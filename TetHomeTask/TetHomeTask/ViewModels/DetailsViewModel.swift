//
//  DetailsViewModel.swift
//  TetHomeTask
//

import SwiftUI

class DetailsViewModel: ObservableObject {
    @Published var selectedCountry: Country
    @Published var selectedLanguage: String?
    @ObservedObject var countriesViewModel: CountriesViewModel
    
    var countryFlagImageUrl: String {
        get {
            return FlagsApi.getCountryFlagImageUrl(countryCode: selectedCountry.cca2)
        }
    }
    
    var neighboringCountries: [Country] {
        get {
            let neighbors = selectedCountry.borders ?? [];
            return countriesViewModel.countries.filter { neighbors.contains($0.cca3) }
        }
    }
    
    var hasNeighbors: Bool {
        get {
            return selectedCountry.borders != nil && selectedCountry.borders?.count ?? 0 > 0;
        }
    }
    
    var isFavouriteCountry: Bool {
        get {
            return selectedCountry.isFavorite ?? false
        }
    }
    
    
    init(selectedCountry: Country, countriesViewModel: CountriesViewModel) {
        self.selectedCountry = selectedCountry
        self.countriesViewModel = countriesViewModel
    }
    
    func getCountriesWithLanguage(language: String) -> [Country] {
        return countriesViewModel.countries.filter {
            $0.languages?.values.contains(selectedLanguage ?? "") == true && $0.cca2 != selectedCountry.cca2
        }
    }
    
    func addToFavorites() {
        countriesViewModel.addToFavorites(country: selectedCountry)
        if let updatedCountry = countriesViewModel.countries.first(where: { $0.id == selectedCountry.id }) {
            selectedCountry = updatedCountry 
        }
    }
}
