//
//  DepartmentListView.swift
//  EmployeeListWithSwiftData
//
//  Created by Roro Solutions LLP on 13/06/23.
//


import SwiftData
import SwiftUI

struct DepartmentListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \.name, order: .forward) var allDepartments: [Department]
    @State var departmentText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Add a department") {
                    TextField("Enter department name", text: $departmentText, axis: .vertical)
                        .lineLimit(1)
                        
                    Button("Save") {
                        createDepartment()
                    }
                    .disabled(departmentText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
            
            Section {
                if allDepartments.isEmpty {
                    ContentUnavailableView("You don't have any department yet", systemImage: "tag")
                } else {
                    ForEach(allDepartments) { department in
                        if department.employees.count > 0 {
                            DisclosureGroup("\(department.name) (\(department.employees.count))") {
                                ForEach(department.employees) { employee in
                                    Text(employee.name)
                                }
                                .onDelete { indexSet in
                                    indexSet.forEach { index in
                                        context.delete(department.employees[index])
                                    }
                                    try? context.save()
                                }
                            }
                        } else {
                            Text(department.name)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allDepartments[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }
    
    func createDepartment() {
        let department = Department(id: UUID().uuidString, name: departmentText, employees: [])
        context.insert(department)
        try? context.save()
        departmentText = ""
    }
}

#Preview {
    DepartmentListView()
}

