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
                NavigationLink(ms.tips, destination: Tips().navigationTitle(ms.tips))
                NavigationLink(ms.depositos, destination: Depositos().navigationTitle(ms.depositos))
                NavigationLink(ms.cheques, destination: Cheques().navigationTitle(ms.cheques))
                NavigationLink(ms.gastos, destination: Gastos().navigationTitle(ms.gastos))
                NavigationLink(ms.beneficiarios, destination: Beneficiarios().navigationTitle(ms.beneficiarios))
                NavigationLink(ms.payroll, destination: PayRoll().navigationTitle(ms.payroll))
                NavigationLink(ms.empleados, destination: Empleados().navigationTitle(ms.empleados))
                NavigationLink(ms.contador, destination: Contador().navigationTitle(ms.contador))
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
