//
//  ContentView.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    
    @EnvironmentObject private var uc: UserController
    @State private var internetConnected = NetworkReachabilityManager()!.isReachable
    
    var body: some View {
        if internetConnected {
            if uc.queriesDone {
                if uc.isiCloudUser {
                    if uc.isUserLogIn {
                        if uc.isUserSignIn {
                            if !uc.currentRestaurantLink.isEmpty {
                                OptionsMenu()
                            } else { RestaurantSelection() }
                        } else { SignIn() }
                    } else { LogIn() }
                } else { NoiCloudAccount() }
            } else { downloadingData }
        } else { noInternetConnection }
    }
    
    var noInternetConnection: some View {
        VStack {
            Image(systemName: "wifi.slash").foregroundColor(Color.red).font(.system(size: 200))
            Text("No hay internet").font(.system(size: 60))
            Text("Reinicia la aplicación si ya estas conectado")
            Button("Reintentar", action: checkInternetConnectivity)
        }
    }
    
    var downloadingData: some View {
        HStack {
            Image(systemName: "icloud.and.arrow.down").foregroundColor(.blue).font(.largeTitle)
            Text("Obteniendo datos")
        }
    }
    
    func checkInternetConnectivity() {
        uc.loadUserInfo()
        internetConnected = NetworkReachabilityManager()!.isReachable
    }
}
