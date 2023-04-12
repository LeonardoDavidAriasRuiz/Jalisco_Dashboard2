//
//  Cuenta.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import SwiftUI

struct Cuenta: View {
    
    private let firstNameTitleTF = "Nombre"
    private let lastNameTitleTF = "Apellido"
    private let emailTitleTF = "Email"
    private let pinTitleTF = "Pin de 4 números"
    
    @Binding var tint: Color
    
    @EnvironmentObject private var uc: UserController
    @EnvironmentObject private var rc: RestauranteController
    
    @State private var vinculo = ""
    @State private var isVinculoPressed = false
    @State private var isNuevoPressed = false
    @State private var newRestaurante = RestauranteModel()
    
    @State private var alert: Bool = false
    
    var body: some View {
        VStack {
            ScrollView {
                userInfo
                restaurantsList
            }
            .frame(maxWidth: 800)
            .padding(20)
        }.modifier(WallColor(wallpaper: "WallBlue"))
        .onAppear(perform: onAppear)
    }
    
    private var userInfo: some View {
        VStack {
            Text("Información").bold().font(.title)
            TextField(firstNameTitleTF, text: $uc.userModel.name).modifier(TextFieldLogIn())
            TextField(lastNameTitleTF, text: $uc.userModel.lastName).modifier(TextFieldLogIn())
            TextField(emailTitleTF, text: $uc.userModel.email).modifier(TextFieldLogIn())
            TextField(pinTitleTF, text: $uc.userModel.pin).modifier(TextFieldLogIn())
        }
    }
    
    private var restaurantsList: some View {
        VStack {
            Text("Restaurantes").bold().font(.title)
                ForEach(uc.restaurantes, id: \.self) {restaurant in
                    HStack {
                        VStack {
                            Button(action: {uc.setCurrentRestaurant(restaurant: restaurant)}) {
                                Image(systemName: "hand.point.up.left.fill")
                                    .modifier(ButtonColor(color: Color.blue))
                            }
                            Button(action: {}) {
                                Image(systemName: "trash.fill")
                                    .modifier(ButtonColor(color: Color.red))
                            }
                        }
                        Spacer()
                        VStack {
                            Text(restaurant.name).bold().font(.title3).foregroundColor(.blue)
                            Text(restaurant.linkAdmin).foregroundColor(.secondary)
                            Text(restaurant.linkEmployee).foregroundColor(.secondary)
                        }
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(20)
                }
                
                HStack {
                    if !isNuevoPressed {
                        Button("Vincular", action: linkRestaurante)
                            .modifier(ButtonColor(color: Color.blue))
                    }
                    if isVinculoPressed {
                        TextField("Vínculo de restaurante existente",text: $vinculo).padding(.horizontal, 10)
                    }
                    if isNuevoPressed {
                        TextField("Nombre del restaurante", text: $newRestaurante.name).padding(.horizontal, 10)
                    }
                    if !isVinculoPressed {
                        Button("Nuevo", action: createRestaurante)
                            .modifier(ButtonColor(color: Color.blue))
                    }
                    if isNuevoPressed || isVinculoPressed {
                        Button("Guardar", action: saveLink)
                            .modifier(ButtonColor(color: Color.green))
                            .bold()
                            .alert("Rellena el espacio.", isPresented: $alert, actions: {})
                    }
                }
                .background(isNuevoPressed || isVinculoPressed ? Color.white : Color.clear)
                .cornerRadius(20)
        }
    }
    
    private func saveLink() {
        withAnimation {
            print("Vinculo \(vinculo)")
            print("Nombre \(newRestaurante.name)")
            if vinculo.isEmpty && newRestaurante.name.isEmpty {
                alert = true
            } else {
                if isVinculoPressed {
                    uc.userModel.restaurants.append(vinculo)
                    linkRestaurante()
                } else if isNuevoPressed {
                    uc.userModel.restaurants.append(newRestaurante.linkAdmin)
                    rc.addRestaurante(restaurante: newRestaurante)
                    createRestaurante()
                }
                uc.saveRestaurantInUser()
            }
        }
    }
    
    private func linkRestaurante() {
        withAnimation {
            isVinculoPressed.toggle()
            if isNuevoPressed == false {
                vinculo = ""
            }
        }
    }
    
    private func createRestaurante() {
        withAnimation {
            isNuevoPressed.toggle()
            if isNuevoPressed == false {
                newRestaurante = RestauranteModel()
            }
        }
    }
    
    private func onAppear() {
        tint = .blue
    }
}
