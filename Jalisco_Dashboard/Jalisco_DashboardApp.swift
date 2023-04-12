//
//  Jalisco_DashboardApp.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

@main
struct Jalisco_DashboardApp: App {
    
    private let uc = UserController()
    private let rc = RestauranteController()
    private let ec = EmpleadoController()
    private let sc = SpendingController()
    
    var body: some Scene {
        WindowGroup {
//            Email()
            ContentView()
                .environmentObject(uc)
                .environmentObject(rc)
                .environmentObject(ec)
                .environmentObject(sc)
                .preferredColorScheme(ColorScheme.light)
        }
    }
}
