//
//  DetailsView.swift
//  TetHomeTask
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
    @State private var selectedLanguage: String?
 
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    HStack {
                        AsyncImageView(url: "https://flagsapi.com/\(viewModel.selectedCountry.cca2)/flat/64.png")
                        VStack (alignment: .leading){
                            Text(viewModel.selectedCountry.name.common).bold()
                            Text(viewModel.selectedCountry.name.official).italic()
                            
                        }
                        Spacer()
                        Button(action: {
                            viewModel.addToFavorites()
                        }) {
                            Image(systemName: viewModel.selectedCountry.isFavorite ?? false ? "star.fill" : "star")
                                .foregroundColor(viewModel.selectedCountry.isFavorite ?? false ? Colors.themeFavoriteSelectedForeground : Colors.themeFavoriteUnselectedForeground)
                                
                        }
                    }
                    VStack(alignment: .leading) {
                        if let capitalName = viewModel.selectedCountry.capital?.first {
                            PropertyCell(property: "Capital", value: capitalName)
                        }
                        PropertyCell(property: "Country code", value: viewModel.selectedCountry.cca2)
                        PropertyCell(property: "Population", value: "\(viewModel.selectedCountry.population)")
                        PropertyCell(property: "Population rank", value: "\(viewModel.selectedCountry.globalPopulationRank)")
                        PropertyCell(property: "Area", value: "\(viewModel.selectedCountry.area)")
                    }
                    MapView(selectedCountry: viewModel.selectedCountry)
                                            .frame(height: 300)
                }
                
                if let languages = viewModel.selectedCountry.languages {
                    Section {
                        ForEach(Array(languages.values), id: \.self) { language in
                            Text(language)
                                .foregroundStyle(Colors.themeLanguageForeground)
                                .onTapGesture {
                                    withAnimation {
                                        selectedLanguage = language
                                    }
                                }
                        }
                    } header: {
                        Text("Languages").bold()
                    }
                    
                    if let selectedLanguage = selectedLanguage {
                        Section {
                            ForEach(viewModel.countriesViewModel.countries.filter { $0.languages?.values.contains(selectedLanguage) == true && $0.cca2 != viewModel.selectedCountry.cca2 }, id: \.self) { country in
                                NavigationLink(
                                    destination: DetailsView(
                                        viewModel: DetailsViewModel(selectedCountry: country, countriesViewModel: viewModel.countriesViewModel)
                                    )
                                ) {
                                    CountryCell(country: country)
                                }
                            }
                        } header: {
                            Text("Countries that speak the same language").bold()
                        }
                    }
                }

                if let neighbors = viewModel.selectedCountry.borders {
                    Section {
                        ForEach(Array(neighbors), id: \.self) { neighbor in
                            if let country = viewModel.countriesViewModel.countries.first(where: { $0.cca3 == neighbor}) {
                                NavigationLink(
                                    destination: DetailsView(
                                        viewModel: DetailsViewModel(selectedCountry: country, countriesViewModel: viewModel.countriesViewModel)
                                    )
                                ) {
                                    CountryCell(country: country)
                                }
                            }
                        }
                    } header: {
                        Text("Neighboring countries").bold()
                    }
                }
            }
        }
    }
}

