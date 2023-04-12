//
//  RestauranteController.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import Foundation
import CloudKit


class RestauranteController: ObservableObject {
    
    func addRestaurante(restaurante: RestauranteModel) {
        let newRestaurant = CKRecord(recordType: "Restaurantes")
        newRestaurant["name"] = restaurante.name
        newRestaurant["linkAdmin"] = restaurante.linkAdmin
        newRestaurant["linkEmployee"] = restaurante.linkEmployee
        
        saveRestaurant(record: newRestaurant)
    }
    
    private func saveRestaurant(record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { returnedRecord, returnError in
//            print(returnedRecord as Any)
//            print(returnError as Any)
        }
    }
    
    
}
