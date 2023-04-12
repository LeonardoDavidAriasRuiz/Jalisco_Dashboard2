//
//  EmpleadoController.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 07/04/23.
//

import CloudKit
import SwiftUI

class EmpleadoController: ObservableObject {
    
    @EnvironmentObject private var uc: UserController
    
    @Published var currentRestaurantLink: String = ""
    @Published var empleados: [EmpleadoModel] = []
    
    func deleteEmpleado(_ empleado: EmpleadoModel) {
        let predicate = NSPredicate(format: "id == %@", empleado.id)
        let query = CKQuery(recordType: "Empleados", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (_, result) in
            guard case .success(let record) = result else { return }
            CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { (recordID, _) in
                self.fetchEmployees()
            }
            self.saveEmpleado(record: record)
        }
        addQueryOperation(queryOperation)
    }
    
    func addEmpleado(_ empleado: EmpleadoModel) {
        let newEmpleado = CKRecord(recordType: "Empleados")
        newEmpleado["id"] = empleado.id
        newEmpleado["name"] = empleado.name
        newEmpleado["lastName"] = empleado.lastName
        newEmpleado["restaurantLink"] = currentRestaurantLink
        
        saveEmpleado(record: newEmpleado)
    }
    
    func updateEmpleado(empleado: EmpleadoModel) {
        let predicate = NSPredicate(format: "id == %@", empleado.id)
        let query = CKQuery(recordType: "Empleados", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (_, result) in
            guard case .success(let record) = result else { return }
            record["name"] = empleado.name
            record["lastName"] = empleado.lastName
            self.saveEmpleado(record: record)
        }
        addQueryOperation(queryOperation) 
    }
    
    private func saveEmpleado(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { record, _ in
            guard let _ = record else { return }
            self.fetchEmployees()
        }
    }
    
    func fetchEmployees() {
        DispatchQueue.main.async {
            self.empleados = []
        }
        
        let predicate = NSPredicate(format: "restaurantLink == %@", currentRestaurantLink)
        let query = CKQuery(recordType: "Empleados", predicate: predicate)
        query.sortDescriptors = [NSSortDescriptor (key: "lastName", ascending: true)]
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (_, result) in
            guard case .success(let record) = result,
                  let id: String = record["id"],
                  let name: String = record["name"],
                  let lastName: String = record["lastName"],
                  let restaurantLink: String = record["restaurantLink"] else { return }
            DispatchQueue.main.sync {
                
                let empleado = EmpleadoModel(id: id, name: name, lastName: lastName, restaurantLink: restaurantLink)
                self.empleados.append(empleado)
            }
        }
        
        queryOperation.queryResultBlock = { returnedResult in
            DispatchQueue.main.sync {
                self.empleados = self.empleados
            }
        }
        
        addQueryOperation(queryOperation)
        
    }
    
    func addQueryOperation(_ qo: CKQueryOperation) {
        CKContainer.default().publicCloudDatabase.add(qo)
    }
}
