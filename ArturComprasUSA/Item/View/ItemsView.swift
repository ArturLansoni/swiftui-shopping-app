//
//  ItemsView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import SwiftUI

struct ItemsView: View {
    @State private var path = NavigationPath()
    @Environment(\.modelContext) var modelContext

    var body: some View {
        NavigationStack(path: $path) {
            ItemListingView()
                .navigationTitle("Lista de compras")
                .navigationDestination(for: NavigationType.self) { type in
                    switch type {
                    case .form(let item):
                        ItemFormView(item: item, path: $path)
                    }
                }
                .toolbar {
                    Button("", systemImage: "plus") {
                        path = NavigationPath([NavigationType.form(nil)])
                    }
                }
        }
    }
}

#Preview {
    ItemsView()
}
