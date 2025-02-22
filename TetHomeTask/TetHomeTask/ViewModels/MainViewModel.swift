//
//  MainViewModel.swift
//  TetHomeTask
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published  var countriesViewModel: CountriesViewModel
    
    var filteredCountries: [Country] {
        get {
            if searchText.isEmpty {
                return countriesViewModel.countries
            }
            
            return countriesViewModel.countries.filter { country in
                let isSearchMatch = country.name.common.localizedCaseInsensitiveContains(searchText)
                let isTranslationMatch = country.translations.contains { _, translation in
                    translation.common.localizedCaseInsensitiveContains(searchText) == true
                }
                
                return isSearchMatch || isTranslationMatch
            }
        }
    }
    
    init()  {
        self.countriesViewModel = CountriesViewModel(countries: [])
    }
    
    func getCountries() async {
        
        do {
            let countries = try await CoutriesAPI.getCountries()
            countriesViewModel.updateCountries(countries)
            objectWillChange.send()
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}
