//
//  EmpleadosModel.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import Foundation

struct EmpleadoModel: Hashable {
    var id: String
    var name: String
    var lastName: String
    var restaurantLink: String
    
    init(id: String, name: String, lastName: String, restaurantLink: String) {
        self.id = id
        self.name = name
        self.lastName = lastName
        self.restaurantLink = restaurantLink
    }
    
    init() {
        self.id = UUID().uuidString
        self.name = ""
        self.lastName = ""
        self.restaurantLink = ""
    }
}
