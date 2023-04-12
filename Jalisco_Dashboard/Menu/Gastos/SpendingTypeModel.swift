//
//  SpendingTypeModel.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 07/04/23.
//

import Foundation

struct SpendingTypeModel: Hashable {
    var id: String
    var name: String
    var description: String
    var restaurantLink: String
    
    init(id: String, name: String, description: String, restaurantLink: String) {
        self.id = id
        self.name = name
        self.description = description
        self.restaurantLink = restaurantLink
    }
    
    init() {
        self.id = UUID().uuidString
        self.name = ""
        self.description = ""
        self.restaurantLink = ""
    }
}
