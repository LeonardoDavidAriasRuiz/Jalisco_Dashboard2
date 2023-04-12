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

struct WallColor: ViewModifier {
    let wallpaper: String
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(content: {Image(wallpaper).resizable().scaledToFill().opacity(0.3).ignoresSafeArea()})
    }
}

struct ButtonColor: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .background(color)
            .cornerRadius(20)
            .foregroundColor(Color.white)
    }
}

struct TextFieldLogIn: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .padding(.horizontal, 30)
            .padding(.vertical, 10)
            .background(Color.white)
            .cornerRadius(20)
            .padding(.vertical, 10)
    }
}

struct TextFieldSpendings: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(10)
            .padding(.leading, 10)
            .background(Color("ListBackground"))
            .cornerRadius(20)
    }
}
