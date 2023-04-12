//
//  Cheques.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Cheques: View {
    
    @Binding var tint: Color
    
    var body: some View {
        VStack {
            Text("Hellow")
        }.modifier(WallColor(wallpaper: "WallDarkGreen"))
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        tint = Color("DarkGreen")
    }
}

struct Cheques_Previews: PreviewProvider {
    static var previews: some View {
        @State var tint = Color.red
        Cheques(tint: $tint)
    }
}
