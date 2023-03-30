//
//  EmpleadosModel.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import Foundation

struct EmpleadoModel {
    let id: UUID
    var firstName: String
    var lastName: String
    
    init(firstName: String, lastName: String) {
        self.id = UUID()
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init() {
        self.id = UUID()
        self.firstName = ""
        self.lastName = ""
    }
}
