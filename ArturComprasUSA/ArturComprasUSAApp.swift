//
//  ArturComprasUSAApp.swift
//  ArturComprasUSA
//
//  Created by Artur Cristiano Lansoni on 29/01/24.
//

import SwiftUI
import SwiftData

@main
struct ArturComprasUSAApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: Item.self)
    }
}
