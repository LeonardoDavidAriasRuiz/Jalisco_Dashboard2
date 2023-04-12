//
//  LogIn.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import SwiftUI

struct LogIn: View {
    
    let firstNameTitleTF = "Nombre"
    let lastNameTitleTF = "Apellido"
    let emailTitleTF = "Email"
    let pinTitleTF = "Pin de 4 números"
    
    @EnvironmentObject private var uc: UserController
    @EnvironmentObject private var rc: RestauranteController
    
    @State private var newCustomUser = CustomUserModel()
    @State private var notSaveUserAlert = false
    
    @State private var vinculo = ""
    @State private var isVinculoPressed = false
    @State private var isNuevoPressed = false
    @State private var newRestaurante = RestauranteModel()
    
    var body: some View {
        VStack {
            VStack {
                Text("Registro").bold().font(.system(size: 90))
                TextField(firstNameTitleTF, text: $newCustomUser.name).modifier(TextFieldLogIn())
                TextField(lastNameTitleTF, text: $newCustomUser.lastName).modifier(TextFieldLogIn())
                TextField(emailTitleTF, text: $newCustomUser.email).modifier(TextFieldLogIn())
                TextField(pinTitleTF, text: $newCustomUser.pin).modifier(TextFieldLogIn())
                
                HStack {
                    
                    if !isNuevoPressed {
                        Button("Vincular", action: linkRestaurante)
                            .modifier(ButtonColor(color: Color.blue))
                    }
                    if isVinculoPressed {
                        TextField("Vínculo de restaurante existente",text: $vinculo)
                            .padding(10)
                    }
                    if isNuevoPressed {
                        TextField("Nombre del restaurante", text: $newRestaurante.name)
                            .padding(10)
                    }
                    if !isVinculoPressed {
                        Button("Nuevo", action: createRestaurante)
                            .modifier(ButtonColor(color: Color.green))
                        
                    }
                }
                .background(Color("ListBackground"))
                .cornerRadius(20)
                
                if !areFieldsCorrectly() {
                    Text("Ingresa correctamente los datos")
                        .modifier(ButtonColor(color: Color.red))
                } else {
                    Button("Guardar", action: saveUserAndLinkRestaurant)
                        .modifier(ButtonColor(color: Color.blue))
                }
            }
            .frame(maxWidth: 400)
            
        }
        .modifier(WallColor(wallpaper: ""))
    }
    
    func areFieldsCorrectly() -> Bool {
        if !newCustomUser.name.isEmpty,
           !newCustomUser.lastName.isEmpty,
           !newCustomUser.email.isEmpty,
           newCustomUser.pin.count == 4,
           Int(newCustomUser.pin) != nil,
           !vinculo.isEmpty || !newRestaurante.name.isEmpty {
            return true
        }
        return false
    }
    
    
    func saveUserAndLinkRestaurant() {
        if isVinculoPressed {
            newCustomUser.restaurants = [vinculo]
        } else if isNuevoPressed {
            newCustomUser.restaurants = [newRestaurante.linkAdmin]
            rc.addRestaurante(restaurante: newRestaurante)
        }
        
        uc.addUser(user: newCustomUser)
        uc.userModel = newCustomUser
        uc.isUserLogIn = true
    }
    
    func linkRestaurante() {
        withAnimation {
            isVinculoPressed.toggle()
            if isNuevoPressed == false {
                vinculo = ""
            }
        }
    }
    
    func createRestaurante() {
        withAnimation {
            isNuevoPressed.toggle()
            if isNuevoPressed == false {
                newRestaurante.name = ""
            }
        }
    }
}
