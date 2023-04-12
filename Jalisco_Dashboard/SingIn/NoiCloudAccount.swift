//
//  NoiCloudAccount.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 01/04/23.
//

import SwiftUI

struct NoiCloudAccount: View {
    
    private let notiCloudMSG = "No tienes una cuenta de iCloud iniciada en el dispositivo"
    private let notiCloudMSGPadding: CGFloat = 20
    private let notiCloudIcon = "exclamationmark.icloud.fill"
    private let notiCloudIconColor = Color.yellow
    private let notiCloudIconFont = Font.largeTitle
    
    var body: some View {
        VStack {
            Image(systemName: notiCloudIcon)
                .font(notiCloudIconFont)
                .foregroundColor(notiCloudIconColor)
            Text(notiCloudMSG)
                .padding(notiCloudMSGPadding)
        }
    }
}

struct NoiCloudAccount_Previews: PreviewProvider {
    static var previews: some View {
        NoiCloudAccount()
    }
}
