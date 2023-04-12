//
//  Corte.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 05/04/23.
//

import SwiftUI

struct Corte: View {
    
    @Binding var tint: Color
    
    var body: some View {
        VStack {
            Text("Hellow")
        }.modifier(WallColor(wallpaper: "WallRed"))
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        tint = .red
    }
}

struct Corte_Previews: PreviewProvider {
    static var previews: some View {
        @State var tint = Color.red
        Corte(tint: $tint)
    }
}
