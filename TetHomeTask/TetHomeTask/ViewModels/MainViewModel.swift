//
//  MainViewModel.swift
//  TetHomeTask
//

import Foundation

@MainActor
class MainViewModel: ObservableObject {
    @Published var countries: [Country] = []
    @Published  var countriesViewModel: CountriesViewModel
    
    init()  {
        self.countriesViewModel = CountriesViewModel(countries: [])
    }
    
    func getCountries() async {
        
        do {
            countries = try await RequestManager.getCountries()
            countriesViewModel.updateCountries(countries)
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}
