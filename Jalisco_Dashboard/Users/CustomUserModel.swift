//
//  CustomUserModel.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import Foundation
import CloudKit

struct CustomUserModel {
    var name: String
    var lastName: String
    var email: String
    var pin: String
    var restaurants: [String]
    
    init(name: String, lastName: String, email: String, pin: String, restaurants: [String]) {
        self.name = name
        self.lastName = lastName
        self.email = email
        self.pin = pin
        self.restaurants = restaurants
    }
    
    init() {
        self.name = ""
        self.lastName = ""
        self.email = ""
        self.pin = ""
        self.restaurants = [""]
    }
}
