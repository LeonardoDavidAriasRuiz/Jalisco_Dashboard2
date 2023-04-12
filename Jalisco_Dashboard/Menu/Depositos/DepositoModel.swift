//
//  DepositoModel.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import Foundation

struct DepositoModel {
    var quantity: Double
    var date: Date
    
    init(quantity: Double, date: Date) {
        self.quantity = quantity
        self.date = date
    }
    
    init() {
        self.quantity = 2000
        self.date = Date()
    }
}
