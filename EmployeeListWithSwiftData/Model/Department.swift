//
//  Department.swift
//  EmployeeListWithSwiftData
//
//  Created by Gaurav Tak on 13/06/23.
//

import Foundation
import SwiftData

@Model
class Department {
    @Attribute(.unique) var id: String?
    var name: String
    
    @Relationship var employees: [Employee]
    @Attribute(.transient) var isChecked = false
    
    init(id: String, name: String, employees: [Employee]) {
        self.id = id
        self.name = name
        self.employees = employees
    }
}

