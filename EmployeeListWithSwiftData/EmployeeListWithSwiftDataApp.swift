//
//  EmployeeListWithSwiftDataApp.swift
//  EmployeeListWithSwiftData
//
//  Created by Roro Solutions LLP on 13/06/23.
//

import SwiftUI
import SwiftData

@main
struct EmployeeListWithSwiftDataApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Item.self)
    }
}
