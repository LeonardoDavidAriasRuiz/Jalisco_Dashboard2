//
//  SpendingController.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 11/04/23.
//

import CloudKit
import SwiftUI

class SpendingController: ObservableObject {
    @Published var spendingTypes: [SpendingTypeModel] = []
    
    func addSpendingType(_ type: SpendingTypeModel) {
        let newType = CKRecord(recordType: "GastoTipos")
        newType["id"] = type.id
        newType["name"] = type.name
        newType["description"] = type.description
        newType["restaurantLink"] = type.restaurantLink
        
        saveRecord(record: newType)
    }
    
    private func saveRecord(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { record, _ in
            guard let _ = record else { return }
        }
    }
}
