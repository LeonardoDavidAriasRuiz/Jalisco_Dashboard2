//
//  Empleados.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Empleados: View {
    
    @State private var newEmpleado = EmpleadoModel()
    
    var body: some View {
        VStack {
            newEmpleadoArea
            empleadosListArea
        }
        .background(Color("ListBackground"))
    }
    
    private var empleadosListArea: some View {
        List {
            Text("a")
            Text("a")
            Text("a")
            Text("a")
        }
        .listStyle(PlainListStyle())
        .cornerRadius(10)
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
    
    private var newEmpleadoArea: some View {
        HStack {
            TextField("Nombre", text: $newEmpleado.firstName)
                .modifier(HeaderAreas())
                .padding(.leading, 20)
            TextField("Apellido", text: $newEmpleado.lastName)
                .modifier(HeaderAreas())
                .padding(.horizontal, 10)
            Button("Agregar", action: {})
                .modifier(HeaderAreas())
                .padding(.trailing, 20)
        }
    }
}

struct Empleados_Previews: PreviewProvider {
    static var previews: some View {
        Empleados()
    }
}
