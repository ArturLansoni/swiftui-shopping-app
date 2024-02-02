//
//  ItemListingRow.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import SwiftData
import SwiftUI

struct ItemListingRow: View {
    var item: Item

    var body: some View {
        HStack(spacing: 12) {

            if let data = item.image,
               let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 80)
                    .clipped()
                    .cornerRadius(8)
                    .shadow(radius: 4, x: 2, y: 2)
            } else {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 80)
                    .foregroundColor(.gray.opacity(0.3))
                    .clipped()
            }

            Text(item.name)
            
            Spacer()

            Text((item.value ?? 0.0).formatToCurrency(locale: Locale(identifier: "en_US")))
        }
    }
}

#Preview {
    do {
        let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: configuration)
        let item = Item(name: "Shoes",
                        tax: 2.5,
                        value: 10.0,
                        isPurchasedWithCard: true,
                        picture: nil)

        return ItemListingRow(item: item)
            .modelContainer(container)
    } catch {
        fatalError("Não consegui criar o Preview")
    }
}
