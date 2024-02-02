//
//  Item.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var name: String
    var tax: Double?
    var value: Double?
    var isPurchasedWithCard: Bool
    var image: Data?
    
    init(name: String = "", tax: Double? = nil, value: Double? = nil, isPurchasedWithCard: Bool = false, picture: Data? = nil) {
        self.name = name
        self.tax = tax
        self.value = value
        self.isPurchasedWithCard = isPurchasedWithCard
        self.image = picture
    }
}
