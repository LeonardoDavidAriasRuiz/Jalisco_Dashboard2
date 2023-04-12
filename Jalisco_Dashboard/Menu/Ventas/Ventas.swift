//
//  Ventas.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Ventas: View {
    
    @Binding var tint: Color
    
    var body: some View {
        VStack {
            Text("Hellow")
        }.modifier(WallColor(wallpaper: "WallGreen"))
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        tint = .green
    }
}

struct Ventas_Previews: PreviewProvider {
    static var previews: some View {
        @State var tint = Color.red
        Ventas(tint: $tint)
    }
}
