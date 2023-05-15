//
//  EmployeeController.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 07/04/23.
//

import CloudKit
import SwiftUI

class EmployeeController: ObservableObject {
    
    @EnvironmentObject private var userC: UserController
    
    @Published var currentRestaurantLink: String = ""
    @Published var employees: [EmployeeModel] = []
    
    private let publicCloudDB = CKContainer.default().publicCloudDatabase
    private let recordType = "Empleados"
    private let idkKey = "id"
    private let nameKey = "name"
    private let lastNameKey = "lastName"
    private let restaurantLinkKey = "restaurantLink"
    
    func deleteEmployee(_ employee: EmployeeModel) {
        let predicate = NSPredicate(format: "\(idkKey) == %@", employee.id)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (_, result) in
            guard case .success(let record) = result else { return }
            self.publicCloudDB.delete(withRecordID: record.recordID) { (recordID, _) in
                self.fetchEmployees()
            }
            self.saveEmployee(record: record)
        }
        addQueryOperation(queryOperation)
    }
    
    func addEmployee(_ employee: EmployeeModel) {
        let newEmployee = CKRecord(recordType: recordType)
        newEmployee[idkKey] = employee.id
        newEmployee[nameKey] = employee.name
        newEmployee[lastNameKey] = employee.lastName
        newEmployee[restaurantLinkKey] = currentRestaurantLink
        
        saveEmployee(record: newEmployee)
    }
    
    func updateEmployee(employee: EmployeeModel) {
        let predicate = NSPredicate(format: "\(idkKey) == %@", employee.id)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { [self] (_, result) in
            guard case .success(let record) = result else { return }
            record[nameKey] = employee.name
            record[lastNameKey] = employee.lastName
            saveEmployee(record: record)
        }
        
        addQueryOperation(queryOperation) 
    }
    
    private func saveEmployee(record: CKRecord) {
        publicCloudDB.save(record) { [self] record, _ in
            guard let _ = record else { return }
            fetchEmployees()
        }
    }
    
    func fetchEmployees() {
        DispatchQueue.main.async { [self] in
            employees = []
        }
        
        let predicate = NSPredicate(format: "\(restaurantLinkKey) == %@", currentRestaurantLink)
        let query = CKQuery(recordType: recordType, predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor (key: lastNameKey, ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { [self] (_, result) in
            
            guard case .success(let record) = result,
                  let id: String = record[idkKey],
                  let name: String = record[nameKey],
                  let lastName: String = record[lastNameKey],
                  let restaurantLink: String = record[restaurantLinkKey] else { return }
            DispatchQueue.main.async { [self] in
                
                let empleado = EmployeeModel(
                    id: id,
                    name: name,
                    lastName: lastName,
                    restaurantLink: restaurantLink
                )
                
                employees.append(empleado)
                
            }
            
        }
        
        queryOperation.queryResultBlock = { _ in
            DispatchQueue.main.async { [self] in
                employees = employees
            }
        }
        
        addQueryOperation(queryOperation)
        
    }
    
    func addQueryOperation(_ queryOperation: CKQueryOperation) {
        publicCloudDB.add(queryOperation)
    }
}
