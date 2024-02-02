//
//  ItemListingView.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import SwiftData
import SwiftUI

struct ItemListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var items: [Item]

    init() {
        _items = Query()
    }

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(value: NavigationType.form(item)) {
                    ItemListingRow(item: item)
                }
            }
            .onDelete(perform: deleteItem)
        }
        .overlay(Group {
            if (items.isEmpty) {
                Text("Sua lista de compras está vazia")
            }
        })
    }

    private func deleteItem(_ indexSet: IndexSet) {
        for index in indexSet {
            let item = items[index]
            modelContext.delete(item)
        }
    }
}

#Preview {
    ItemListingView()
}
