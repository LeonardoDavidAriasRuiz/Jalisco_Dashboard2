//
//  Contador.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Contador: View {
    @State private var contador = ContadorModel()
    
    var body: some View {
        VStack {
            contadorArea
            messageArea
        }
        .background(Color("ListBackground"))
    }
    
    private var messageArea: some View {
        TextEditor(text: $contador.message)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(10)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.top, 10)
        .padding(.bottom, 20)
        .padding(.horizontal, 20)
    }
    
    private var contadorArea: some View {
        HStack {
            TextField("Nombre", text: $contador.name)
                .modifier(HeaderAreas())
                .padding(.leading, 20)
            TextField("Email", text: $contador.email)
                .modifier(HeaderAreas())
                .padding(.horizontal, 10)
            Button("Actualizar", action: {})
                .modifier(HeaderAreas())
                .padding(.trailing, 20)
        }
    }
}

struct Contador_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Contador().navigationTitle("Contador")
        }
    }
}
