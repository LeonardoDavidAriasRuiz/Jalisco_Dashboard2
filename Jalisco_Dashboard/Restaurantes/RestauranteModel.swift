//
//  RestauranteModel.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import Foundation

struct RestauranteModel: Hashable {
    var name: String
    var linkAdmin: String
    var linkEmployee: String
    
    init(name: String) {
        self.name = name
        self.linkAdmin = UUID().uuidString
        self.linkEmployee = UUID().uuidString
    }
    
    init() {
        self.name = ""
        self.linkAdmin = UUID().uuidString
        self.linkEmployee = UUID().uuidString
    }
    
    init(name: String, linkEmployee: String) {
        self.name = name
        self.linkAdmin = "Vínculo Admin no permitido"
        self.linkEmployee = linkEmployee
    }
    
    init(name: String, linkAdmin: String, linkEmployee: String) {
        self.name = name
        self.linkAdmin = linkAdmin 
        self.linkEmployee = linkEmployee
    }
}
