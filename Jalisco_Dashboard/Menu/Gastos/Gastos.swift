//
//  Gastos.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import SwiftUI

struct Gastos: View {
    
    let months = [
        "Ene", "Feb", "Mar", "Abr", "May", "Jun", "Jul",
        "Ago", "Sep", "Oct", "Nov", "Dic"
    ]
    
    @Binding var tint: Color
    
    @State private var newSpendingType = SpendingTypeModel()
    @State private var newSpending = SpendingModel()
    @State private var newSpendingTypePressed: Bool = false
    
    
    var body: some View {
        VStack {
            newSpendingArea
            
            
            ScrollView {
                newTypeArea
            }.padding(.horizontal, 20)
        }
        .tint(.purple)
        .modifier(WallColor(wallpaper: "WallPurple"))
        .onAppear(perform: onAppear)
    }
    
    private var newSpendingArea: some View {
        VStack {
            Picker("", selection: $newSpending.month) {
                ForEach(months.indices, id: \.self) { index in
                    Text(months[index]).tag(index+1)
                }
            }
            .pickerStyle(.segmented)
            HStack {
                TextField("Cantidad", text: $newSpending.quantity)
                    .padding(10)
                    .padding(.leading, 10)
                    .background(Color("ListBackground"))
                    .cornerRadius(20)
                TextField("Descripción", text: $newSpending.description)
                    .padding(10)
                    .padding(.leading, 10)
                    .background(Color("ListBackground"))
                    .cornerRadius(20)
                Picker("", selection: $newSpending.typeLink) {
                    ForEach(months.indices, id: \.self) { index in
                        Text(months[index]).tag(index+1)
                    }
                }
                .pickerStyle(.menu)
            }
        }
        .padding(15)
        .background(Color.white)
        .cornerRadius(30)
        .padding(.horizontal, 20)
    }
    
    private var newTypeArea: some View {
        HStack {
            if newSpendingTypePressed {
                VStack {
                    TextField("Nombre", text: $newSpendingType.name).modifier(TextFieldSpendings())
                    TextField("Descripción", text: $newSpendingType.description).modifier(TextFieldSpendings())
                }.padding(10)
            }
            Button(action: {withAnimation{newSpendingTypePressed.toggle()}}) {
                VStack {
                    Image(systemName: "plus.circle.fill").font(.system(size: 30))
                    Text("Tipo")
                }
                .padding(.horizontal, 20)
                .foregroundColor(Color.white)
                .frame(maxHeight: .infinity)
                .background(Color.purple.gradient)
                .cornerRadius(30)
            }
        }
        .frame(maxWidth: newSpendingTypePressed ? 800 : 76, idealHeight: 120)
//        .frame(height: 120)
        .background(Color.white)
        .cornerRadius(30)
    }
    
    func onAppear() {
        tint = .purple
    }
}
