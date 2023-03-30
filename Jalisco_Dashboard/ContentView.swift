//
//  ContentView.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var cloudKitUserViewModel = CloudKitUserViewModel()
    private let notSingedInMSG = "No tienes una cuenta de iCloud iniciada en el dispositivo"
    
    var body: some View {
        if cloudKitUserViewModel.isSignedInToiCloud {
            OptionsMenu()
                .preferredColorScheme(ColorScheme.light)
        } else {
            VStack {
                Image(systemName: "exclamationmark.icloud.fill")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                Text(notSingedInMSG)
                    .padding(20)
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
