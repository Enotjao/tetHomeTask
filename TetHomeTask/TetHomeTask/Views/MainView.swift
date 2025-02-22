//
//  ContentView.swift
//  TetHomeTask
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var areCountriesLoaded = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredCountries) { country in
                    NavigationLink(destination: DetailsView(
                        viewModel: DetailsViewModel(selectedCountry: country, countriesViewModel: viewModel.countriesViewModel))) {
                            CountryCell(country: country)
                        }
                }
            }
            .searchable(text: $viewModel.searchText, prompt: "Search Countries")
            .onAppear {
                if !areCountriesLoaded {
                    Task {
                        await viewModel.getCountries()
                        areCountriesLoaded = true
                    }
                }
            }
            .navigationBarTitle("Country Encyclopedia",displayMode: .inline)
        }
    }
}
