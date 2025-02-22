//
//  MainViewModel.swift
//  TetHomeTask
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var countriesViewModel: CountriesViewModel
    @Published var searchText: String = ""
    
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
            let countries = try await RequestManager.getCountries()
            countriesViewModel.updateCountries(countries)
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
    }

    func ad()  {
        viewModel.countriesViewModel.countries.filter { country in
                    searchText.isEmpty || country.name.common.localizedCaseInsensitiveContains(searchText) == true
                    || country.translations.contains { _, translation in
                        translation.common.localizedCaseInsensitiveContains(searchText) == true
                    }
                }
    }
}
