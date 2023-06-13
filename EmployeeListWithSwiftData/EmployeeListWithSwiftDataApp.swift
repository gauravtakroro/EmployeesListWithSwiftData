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
    @State var employeeSearchText = ""
    @State var employeeSortBy = EmployeeSortBy.createdAt
    @State var employeeOrderBy = OrderBy.descending
    
    @State var departmentSearchText = ""
    @State var departmentOrderBy = OrderBy.ascending
   
    var body: some Scene {
        WindowGroup {
            TabView {
                employeeList
                departmentList
            }
            .modelContainer(for: [
                Employee.self,
                Department.self
            ])
        }
    }
    
    var employeeList: some View {
        NavigationStack {
            EmployeeListView(allEmployees: employeeListQuery)
                .searchable(text: $employeeSearchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .navigationTitle("Employees")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Menu {
                            Picker("Sort by", selection: $employeeSortBy) {
                                ForEach(EmployeeSortBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(employeeSortBy.text, systemImage: "line.horizontal.3.decrease.circle")
                        }
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Order by", selection: $employeeOrderBy) {
                                ForEach(OrderBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(employeeOrderBy.text, systemImage: "arrow.up.arrow.down")
                        }
                    }

                }
        }
        .tabItem { Label("Employees", systemImage: "person") }
    }
    
    var employeeListQuery: Query<Employee, [Employee]> {
        let sortOrder: SortOrder = employeeOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Employee>?
        if !employeeSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.name.contains(employeeSearchText) })
        }
        if employeeSortBy == .name {
            return Query(filter: predicate, sort: \.name, order: sortOrder)
        } else  if employeeSortBy == .salary {
            return Query(filter: predicate, sort: \.salaryPerMonth, order: sortOrder)
        } else {
            return Query(filter: predicate, sort: \.createdAt, order: sortOrder)
        }
    }
    
    var departmentList: some View {
        NavigationStack {
            DepartmentListView(allDepartments: departmentListQuery)
                .searchable(text: $departmentSearchText, prompt: "Search")
                .textInputAutocapitalization(.never)
                .navigationTitle("Departments")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Menu {
                            Picker("Order by", selection: $departmentOrderBy) {
                                ForEach(OrderBy.allCases) {
                                    Text($0.text).id($0)
                                }
                            }
                        } label: {
                            Label(departmentOrderBy.text, systemImage: "arrow.up.arrow.down")
                        }
                    }
                }
        }
        .tabItem { Label("Departments", systemImage: "tag") }
    }
    
    var departmentListQuery: Query<Department, [Department]> {
        let sortOrder: SortOrder = departmentOrderBy == .ascending ? .forward : .reverse
        var predicate: Predicate<Department>?
        if !departmentSearchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            predicate = .init(#Predicate { $0.name.contains(departmentSearchText) })
        }
        return Query(filter: predicate, sort: \.name, order: sortOrder)
    }
}
