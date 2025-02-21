//
//  DetailsViewModel.swift
//  TetHomeTask
//

import SwiftUI

class DetailsViewModel: ObservableObject {
    @Published var selectedCountry: Country
    @ObservedObject var countriesViewModel: CountriesViewModel
    
    init(selectedCountry: Country, countriesViewModel: CountriesViewModel) {
        self.selectedCountry = selectedCountry
        self.countriesViewModel = countriesViewModel
    }
    
    func addToFavorites() {
        countriesViewModel.addToFavorites(country: selectedCountry)
        if let updatedCountry = countriesViewModel.countries.first(where: { $0.id == selectedCountry.id }) {
            selectedCountry = updatedCountry 
        }
    }
}
