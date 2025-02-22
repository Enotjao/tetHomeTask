//
//  CountryCell.swift
//  TetHomeTask
//

import SwiftUI

struct CountryCell: View {
    @ObservedObject var country: Country
    
    var body: some View {
        HStack {
            Text(country.flag)
            Text(country.name.common)
            Spacer()
            Image(systemName: country.isFavorite ?? false ? "star.fill" : "star")
                .foregroundColor(country.isFavorite ?? false ? Colors.themeFavoriteSelectedForeground : Colors.themeFavoriteUnselectedForeground)
            
        }
    }
}
