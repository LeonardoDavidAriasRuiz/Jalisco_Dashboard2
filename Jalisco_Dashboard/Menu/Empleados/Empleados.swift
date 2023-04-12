//
//  Empleados.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Empleados: View {
    
    @EnvironmentObject private var ec: EmpleadoController
    @EnvironmentObject private var uc: UserController
    
    @Binding var tint: Color
    
    @State private var empleado = EmpleadoModel()
    @State private var employeeSelected: Bool = false
    
    private let fieldsEmptyTitle: String = "Completa el nombre y apellido"
    @State private var fieldsEmptyAlert: Bool = false
    @State private var deleteEmployeeAlert: Bool = false
    
    var body: some View {
        VStack {
            VStack {
                newEmpleadoArea
                    .alert(fieldsEmptyTitle, isPresented: $fieldsEmptyAlert, actions: {})
                empleadosListArea
            }
            .padding(.horizontal, 20)
        }
        .modifier(WallColor(wallpaper: "WallOrange"))
        .onAppear(perform: onAppear)
    }
    
    private var empleadosListArea: some View {
        List {
            ForEach(ec.empleados, id: \.self) { empleado in
                Button(action: {selectEmpleado(empleado: empleado)}) {
                    HStack {
                        Text(empleado.lastName)
                        Text(empleado.name)
                    }
                }
            }
        }
        .listStyle(PlainListStyle())
        .cornerRadius(10)
        .padding(.top, 10)
    }
    
    private var newEmpleadoArea: some View {
        HStack {
            TextField("Apellido", text: $empleado.lastName)
                .modifier(HeaderAreas())
            TextField("Nombre", text: $empleado.name)
                .modifier(HeaderAreas())
                .padding(.horizontal, 5)
            if employeeSelected {
                Button(action: {ec.updateEmpleado(empleado: empleado)}) {
                    Image(systemName: "gearshape.arrow.triangle.2.circlepath")
                        .modifier(ButtonColor(color: Color.blue))
                }
                Button(action: unselectEmpleado) {
                    Image(systemName: "pencil.slash")
                        .modifier(ButtonColor(color: Color.orange))
                }
                Button(action: deleteEmployeeButtonPressed) {
                    Image(systemName: "trash.fill")
                        .modifier(ButtonColor(color: Color.red))
                }
                .alert(isPresented: $deleteEmployeeAlert) {
                    Alert(
                        title: Text("Eliminar empleado"),
                        message: Text("Estas seguro de que quieres eliminar a \(empleado.lastName) \(empleado.name)"),
                        primaryButton: .destructive(Text("Eliminar"), action: deleteEmployee),
                        secondaryButton: .cancel(Text("Cancelar"))
                    )
                }
            } else {
                Button("Agregar", action: newEmployee)
                    .modifier(HeaderAreas())
            }
        }
    }
    
    func deleteEmployee() {
        ec.deleteEmpleado(empleado)
        
    }
    
    func deleteEmployeeButtonPressed() {
        deleteEmployeeAlert = true
    }
    
    func unselectEmpleado() {
        withAnimation {
            empleado = EmpleadoModel()
            employeeSelected = false
        }
    }
    
    func selectEmpleado(empleado: EmpleadoModel) {
        withAnimation {
            self.empleado = empleado
            employeeSelected = true
        }
    }
    
    func newEmployee() {
        withAnimation {
            if !empleado.name.isEmpty && !empleado.lastName.isEmpty {
                ec.addEmpleado(empleado)
                empleado = EmpleadoModel()
            } else {
                fieldsEmptyAlert = true
            }
        }
    }
    
    func onAppear() {
        tint = .orange
        ec.currentRestaurantLink = uc.currentRestaurantLink
        ec.fetchEmployees()
    }
}

