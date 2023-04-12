//
//  Beneficiarios.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Beneficiarios: View {
    
    @Binding var tint: Color
    
    var body: some View {
        VStack {
            Text("Hellow")
        }.modifier(WallColor(wallpaper: "WallWhite"))
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        tint = .gray
    }
}

struct Beneficiarios_Previews: PreviewProvider {
    static var previews: some View {
        @State var tint = Color.red
        Beneficiarios(tint: $tint)
    }
}
