//
//  SettingsView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage(AppStorageKeys.exchangeRate) private var exchangeRate = EXCHANGE_RATE_DEFAULT_VALUE
    @AppStorage(AppStorageKeys.iof) private var iof = IOF_DEFAULT_VALUE

    var body: some View {
        NavigationStack {
            Form {
                Section("Cotação do dólar (R$)") {
                    TextField("Valor do dólar", value: $exchangeRate, format: .number)
                }
                
                Section("IOF (%)") {
                    TextField("Alíquota IOF", value: $iof, format: .number)
                }
            }
            .navigationTitle("Ajustes")
        }
    }
}

#Preview {
    SettingsView()
}
