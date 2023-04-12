//
//  RestaurantSelection.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 07/04/23.
//

import SwiftUI

struct RestaurantSelection: View {
    
    @EnvironmentObject private var uc: UserController
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(uc.restaurantes, id: \.self) {restaurant in
                    HStack {
                        Button(action: {uc.setCurrentRestaurant(restaurant: restaurant)}) {
                            Text(restaurant.name)
                                .bold()
                                .font(.title3)
                                .foregroundColor(.blue)
                        }
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(20)
                }
            }.padding(.horizontal, 20).frame(maxWidth: 800)
        }.modifier(WallColor(wallpaper: "WallGray"))
    }
}

