//
//  Menu.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI
import CloudKit

struct OptionsMenu: View {
    
    @EnvironmentObject private var uc: UserController
    @State var tint = Color.red
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Corte(tint: $tint).navigationTitle("Corte"), label: {corte})
                if uc.currentRestaurantAdmin {
                    NavigationLink(destination: Ventas(tint: $tint).navigationTitle("Ventas"), label: {ventas})
                    NavigationLink(destination: Tips(tint: $tint).navigationTitle("Tips"), label: {tips})
                    NavigationLink(destination: Depositos(tint: $tint).navigationTitle("Depositos"), label: {depositos})
                    NavigationLink(destination: Gastos(tint: $tint).navigationTitle("Gastos"), label: {gastos})
                    NavigationLink(destination: Beneficiarios(tint: $tint).navigationTitle("Beneficiarios"), label: {beneficiarios})
                    NavigationLink(destination: Cheques(tint: $tint).navigationTitle("Cheques"), label: {cheques})
                    NavigationLink(destination: PayRoll(tint: $tint).navigationTitle("PayRoll"), label: {payroll})
                    NavigationLink(destination: Empleados(tint: $tint).navigationTitle("Empleados"), label: {empleados})
                    NavigationLink(destination: Contador(tint: $tint).navigationTitle("Contador"), label: {contador})
                }
                NavigationLink(destination: Cuenta(tint: $tint).navigationTitle("Cuenta"), label: {cuenta})
            }
            .background(Color("ListBackground"))
            .navigationTitle("Menu")
        }
        .tint(tint)
    }
    
    var corte: some View {
        HStack {
            Image(systemName: "list.bullet.clipboard.fill").foregroundColor(.red)
            Text("Corte")
        }
    }
    var ventas: some View {
        HStack {
            Image(systemName: "chart.bar.fill").foregroundColor(.green)
            Text("Ventas")
        }
    }
    var tips: some View {
        HStack {
            Image(systemName: "dollarsign.circle.fill").foregroundColor(.yellow)
            Text("Tips")
        }
    }
    var depositos: some View {
        HStack {
            Image(systemName: "tray.and.arrow.down.fill").foregroundColor(.teal)
            Text("Depositos")
        }
    }
    var cheques: some View {
        HStack {
            Image(systemName: "banknote.fill").foregroundColor(Color("DarkGreen"))
            Text("Cheques")
        }
    }
    var empleados: some View {
        HStack {
            Image(systemName: "person.3.fill").foregroundColor(.orange)
            Text("Empleados")
        }
    }
    var gastos: some View {
        HStack {
            Image(systemName: "creditcard.fill").foregroundColor(.purple)
            Text("Gastos")
        }
    }
    var beneficiarios: some View {
        HStack {
            Image(systemName: "person.line.dotted.person.fill").foregroundColor(.gray)
            Text("Beneficiarios")
        }
    }
    var payroll: some View {
        HStack {
            Image(systemName: "calendar.badge.clock").foregroundColor(Color("Burgundy"))
            Text("PayRoll")
        }
    }
    var contador: some View {
        HStack {
            Image(systemName: "person.text.rectangle").foregroundColor(.brown)
            Text("Contador")
        }
    }
    var cuenta: some View {
        HStack {
            Image(systemName: "person.crop.circle").foregroundColor(.blue)
            Text("Cuenta")
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        OptionsMenu()
    }
}
