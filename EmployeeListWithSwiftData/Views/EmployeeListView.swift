//
//  EmployeeListView.swift
//  EmployeeListWithSwiftData
//
//  Created by Roro Solutions LLP on 13/06/23.
//


import SwiftData
import SwiftUI

struct EmployeeListView: View {
    
    @Environment(\.modelContext) private var context
    @Query(sort: \.createdAt, order: .reverse) var allEmployees: [Employee]
    @Query(sort: \.name, order: .forward) var allDepartments: [Department]
    @State var employeeText = ""
    @State var salaryPerMonthText = ""
    
    var body: some View {
        List {
            Section {
                DisclosureGroup("Add a Employee") {
                    TextField("Enter name", text: $employeeText, axis: .vertical)
                        .lineLimit(1)
                    TextField("Enter Salary Per Month", text: $salaryPerMonthText, axis: .vertical)
                        .lineLimit(1).keyboardType(.numberPad)
                    
                    DisclosureGroup("Departmet With") {
                        if allDepartments.isEmpty {
                            Text("You don't have any department yet. Please create one from Department tab")
                                .foregroundStyle(Color.gray)
                        }
                        
                        ForEach(allDepartments) { department in
                            HStack {
                                Text(department.name)
                                if department.isChecked {
                                    Spacer()
                                    Image(systemName: "checkmark.circle")
                                        .symbolRenderingMode(.multicolor)
                                }
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                department.isChecked.toggle()
                            }
                        }
                    }
                        
                    Button("Save") {
                        createEmployee()
                    }
                    .disabled(employeeText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        
            Section {
                if allEmployees.isEmpty {
                    ContentUnavailableView("You don't have any employee yet", systemImage: "person")
                } else {
                    ForEach(allEmployees) { employee in
                        VStack(alignment: .leading) {
                            Text(employee.name)
                            if employee.departments.count > 0 {
                                Text("Department:" + employee.departments.map { $0.name }.joined(separator: ", "))
                            }
                            Text("Salary Per Month: Rs. \(employee.salaryPerMonth)")
                            HStack(alignment: .top) {
                                Text("Record Added on:")
                                    .font(.caption)
                                Text(employee.createdAt, style: .date)
                                    .font(.caption)
                                Text(employee.createdAt, style: .time)
                                    .font(.caption)
                            }
                            
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            context.delete(allEmployees[index])
                        }
                        try? context.save()
                    }
                }
            }
        }
    }
    
    func createEmployee() {
        var departments = [Department]()
        allDepartments.forEach { department in
            if department.isChecked {
                departments.append(department)
                department.isChecked = false
            }
        }
        
        let employee = Employee(id: UUID().uuidString, name: employeeText,salaryPerMonth: Int64(salaryPerMonthText) ?? 0 , createdAt: .now, departments: departments)
        context.insert(employee)
        try? context.save()
        employeeText = ""
        salaryPerMonthText = ""
    }
}

#Preview {
    EmployeeListView()
}

