//
//  PropertyCell.swift
//  TetHomeTask
//

import SwiftUI

struct PropertyCell: View {
    let property: String
    let value: String
    
    var body: some View {
        HStack {
            Text(property).bold()
            Spacer()
            Text(value)
        }
    }
}
