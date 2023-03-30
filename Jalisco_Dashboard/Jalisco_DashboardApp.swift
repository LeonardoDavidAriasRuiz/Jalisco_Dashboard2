//
//  Jalisco_DashboardApp.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

@main
struct Jalisco_DashboardApp: App {
    
    @StateObject var cloudKitUserViewModel = CloudKitUserViewModel()
    private let notSingedInMSG = "No tienes una cuenta de Icloud iniciada en el dispositivo"
    var body: some Scene {
        WindowGroup {
            if cloudKitUserViewModel.isSignedInToiCloud {
                ContentView()
                    .preferredColorScheme(ColorScheme.light)
            } else {
                VStack {
                    Image(systemName: "exclamationmark.icloud.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                    Text(notSingedInMSG)
                }
            }
            
        }
    }
}
