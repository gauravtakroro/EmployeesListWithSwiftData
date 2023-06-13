//
//  Item.swift
//  EmployeeListWithSwiftData
//
//  Created by Roro Solutions LLP on 13/06/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
