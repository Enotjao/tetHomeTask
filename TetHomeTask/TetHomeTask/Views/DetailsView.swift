//
//  DetailsView.swift
//  TetHomeTask
//

import SwiftUI

struct DetailsView: View {
    @ObservedObject var viewModel: DetailsViewModel
 
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    HStack {
                        AsyncImageView(url: viewModel.countryFlagImageUrl)
                        VStack (alignment: .leading){
                            Text(viewModel.selectedCountry.name.common).bold()
                            Text(viewModel.selectedCountry.name.official).italic()
                            
                        }
                        Spacer()
                        Button(action: {
                            viewModel.addToFavorites()
                        }) {
                            Image(systemName: viewModel.isFavouriteCountry ? "star.fill" : "star")
                                .foregroundColor(viewModel.isFavouriteCountry ? Colors.themeFavoriteSelectedForeground : Colors.themeFavoriteUnselectedForeground)
                                
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
                                        viewModel.selectedLanguage = language
                                    }
                                }
                        }
                    } header: {
                        Text("Languages").bold()
                    }
                    
                    if let selectedLanguage = viewModel.selectedLanguage {
                        Section {
                            ForEach(viewModel.getCountriesWithLanguage(language: selectedLanguage), id: \.self) { country in
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

                if viewModel.hasNeighbors {
                    Section {
                        ForEach(viewModel.neighboringCountries, id: \.self) { country in
                            NavigationLink(
                                destination: DetailsView(
                                    viewModel: DetailsViewModel(selectedCountry: country, countriesViewModel: viewModel.countriesViewModel)
                                )
                            ) {
                                CountryCell(country: country)
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

