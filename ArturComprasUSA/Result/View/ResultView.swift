//
//  ResultView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 31/01/24.
//

import SwiftData
import SwiftUI

struct ResultView: View {
    @AppStorage(AppStorageKeys.iof) private var iof = IOF_DEFAULT_VALUE
    @AppStorage(AppStorageKeys.exchangeRate) private var exchangeRate = EXCHANGE_RATE_DEFAULT_VALUE
    @Environment(\.modelContext) var modelContext
    @Query private var items: [Item]
    
    init() {
        _items = Query()
    }

    var total: Double {
        items.reduce(0) { $0 + ($1.value ?? 0.0) }
    }
    
    var totalWithTax: Double {
        items.reduce(0) { $0 + calculateTax(item: $1) }
    }
    
    var totalInBRL: Double {
        totalWithTax * exchangeRate
    }

    
    private func calculateTax(item: Item) -> Double {
        let value = (item.value ?? 0.0)
        let tax = (item.tax ?? 0.0)
        let withTax = value + value * (tax / 100)
        
        if (item.isPurchasedWithCard) {
            return withTax + withTax * (iof / 100)
        }
        return withTax
    }

    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    ResultSectionView(
                        description: "Valor dos produtos ($)",
                        value: total.formatToCurrency(locale: Locale(identifier: "en_US")),
                        color: .blue
                    )
                    
                    ResultSectionView(
                        description: "Total com impostos ($)",
                        value: totalWithTax.formatToCurrency(locale: Locale(identifier: "en_US")),
                        color: .red
                    )
                    
                    ResultSectionView(
                        description: "Valor final em reais (R$)",
                        value: totalInBRL.formatToCurrency(locale: Locale(identifier: "pt_BR")),
                        color: .green
                    )
                    
                    Spacer()
                }
                Spacer()
            }
            .navigationTitle("Resumo da compra")
        }
    }
}


#Preview {
    ResultView()
}
