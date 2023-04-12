//
//  PayRoll.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct PayRoll: View {
    
    @Binding var tint: Color
    
    var body: some View {
        VStack {
            Text("Hellow")
        }.modifier(WallColor(wallpaper: "WallBurgundy"))
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        tint = Color("Burgundy")
    }
}

struct PayRoll_Previews: PreviewProvider {
    static var previews: some View {
        @State var tint = Color.red
        PayRoll(tint: $tint)
    }
}
