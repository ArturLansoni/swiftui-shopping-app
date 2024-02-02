//
//  ResultSectionView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 31/01/24.
//

import SwiftUI

struct ResultSectionView: View {
    let description: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(description)
            Spacer().frame(height: 8)
            Text(value)
                .font(.system(size: 32, weight: .bold))
                .foregroundStyle(color)
        }
        .padding()
    }
    
}

#Preview {
    ResultSectionView(description: "Total com impostos ($)",
                      value: "R$ 3.000,00",
                      color: .red)
}
