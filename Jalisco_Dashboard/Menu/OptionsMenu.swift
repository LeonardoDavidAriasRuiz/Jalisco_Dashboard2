//
//  Menu.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct OptionsMenu: View {
    let ms: MenuSections = MenuSections()
    var body: some View {
        NavigationView {
            List {
                NavigationLink(ms.ventas, destination: Ventas().navigationTitle(ms.ventas))
                NavigationLink(ms.tips, destination: {}.navigationTitle(ms.tips))
                NavigationLink(ms.depositos, destination: {}.navigationTitle(ms.depositos))
                NavigationLink(ms.cheques, destination: {}.navigationTitle(ms.cheques))
                NavigationLink(ms.empleados, destination: {}.navigationTitle(ms.empleados))
                NavigationLink(ms.gastos, destination: {}.navigationTitle(ms.gastos))
                NavigationLink(ms.beneficiarios, destination: {}.navigationTitle(ms.beneficiarios))
                NavigationLink(ms.payroll, destination: {}.navigationTitle(ms.payroll))
                NavigationLink(ms.contador, destination: {}.navigationTitle(ms.contador))
            }
            .background(Color(red: 0.949, green: 0.949, blue: 0.966))
        }
    }
}
struct MenuSections {
    let ventas = "Ventas"
    let tips = "Tips"
    let depositos = "Depositos"
    let cheques = "Cheques"
    let empleados = "Empleados"
    let gastos = "Gastos"
    let beneficiarios = "Beneficiarios"
    let payroll = "PayRoll"
    let contador = "Contador"
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        OptionsMenu()
    }
}
