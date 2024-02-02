//
//  MainView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ItemsView()
                .tabItem {
                    Label("Compras", systemImage: "cart.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Ajustes", systemImage: "gearshape")
                }
            
            ResultView()
                .tabItem {
                    Label("Total da compra", systemImage: "dollarsign.circle")
                }
        }
            .accentColor(Color.blue)
    }
}

#Preview {
    MainView()
}

