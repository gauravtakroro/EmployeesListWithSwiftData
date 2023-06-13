//
//  Filters.swift
//  EmployeeListWithSwiftData
//
//  Created by Roro Solutions LLP on 13/06/23.
//


import Foundation

enum EmployeeSortBy: Identifiable, CaseIterable {
    var id: Self { self }
    case createdAt
    case name
    case salary
    
    var text: String {
        switch self {
        case .createdAt: return "Created at"
        case .salary: return "Salary"
        case .name: return "Name"
        }
    }
    
}


enum OrderBy: Identifiable, CaseIterable {
    
    var id: Self { self }
    case ascending
    case descending
    
    var text: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
    
}

