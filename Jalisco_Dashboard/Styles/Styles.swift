//
//  Styles.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct HeaderAreas: ViewModifier {
    
    var padding: CGFloat = 10
    var background: Color = Color.white
    var cornerRadius: CGFloat = 10
    
    func body(content: Content) -> some View {
       content
            .padding(padding)
            .background(background)
            .cornerRadius(cornerRadius)
    }
 }
