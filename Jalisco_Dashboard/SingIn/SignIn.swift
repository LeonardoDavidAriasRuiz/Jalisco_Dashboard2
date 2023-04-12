//
//  SignIn.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import SwiftUI

struct SignIn: View {
    @State private var btnPressedCount = 0
    @State private var alert = false
    @State private var pin = ""
    
    @EnvironmentObject private var uc: UserController
    
    let columns = [
        GridItem(),
        GridItem(),
        GridItem()
    ]
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1..<5) { number in
                    Image(systemName: btnPressedCount >= number ? "circle.fill" : "circle")
                        .font(.title2)
                }
            }
            .padding(.bottom, 50)
            .alert("Pin incorrecto", isPresented: $alert, actions: {})
            
            LazyVGrid(columns: columns) {
                ForEach(1..<10) { number in
                    Button(action: {btnPressed(numberPressed: number)}) {
                        Image(systemName: "\(number).circle.fill")
                            .font(.system(size: 100))
                            .padding(-10)
                            .background(.white)
                            .cornerRadius(100)
                            .foregroundColor(Color.black.opacity(0.7))
                        
                    }
                }
            }.frame(maxWidth: 400)
        }.modifier(WallColor(wallpaper: "WallGray"))
    }
    
    
    private func btnPressed(numberPressed: Int) {
        pin.append(String(numberPressed))
        btnPressedCount += 1
        
        if btnPressedCount >= 4 {
            if pin == uc.userModel.pin {
                withAnimation {
                    uc.isUserSignIn = true
                }
            } else {
                alert = true
                btnPressedCount = 0
                pin = ""
            }
        }
    }
}

struct SignIn_Previews: PreviewProvider {
    static var previews: some View {
        SignIn()
    }
}
