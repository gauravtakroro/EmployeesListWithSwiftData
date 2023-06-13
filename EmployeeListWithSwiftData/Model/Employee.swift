//
//  Employee.swift
//  EmployeeListWithSwiftData
//
//  Created by Roro Solutions LLP on 13/06/23.
//

import Foundation
import SwiftData

@Model
class Employee {
    @Attribute(.unique) var id: String?
    var name: String
    var salaryPerMonth: Int64
    var createdAt: Date
    
    @Relationship(inverse: \Department.employees) var departments: [Department]
    
    init(id: String, name: String, salaryPerMonth: Int64, createdAt: Date, departments: [Department]) {
        self.id = id
        self.name = name
        self.salaryPerMonth = salaryPerMonth
        self.createdAt = createdAt
        self.departments = departments
    }
}
