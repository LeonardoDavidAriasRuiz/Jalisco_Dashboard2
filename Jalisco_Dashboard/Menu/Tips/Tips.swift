//
//  Tips.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Tips: View {
    
    @Binding var tint: Color
    
    var body: some View {
        VStack {
            Text("Hellow")
        }.modifier(WallColor(wallpaper: "WallYellow"))
        .onAppear(perform: onAppear)
    }
    
    func onAppear() {
        tint = .yellow
    }
}

struct Tips_Previews: PreviewProvider {
    static var previews: some View {
        @State var tint = Color.red
        Tips(tint: $tint)
    }
}
