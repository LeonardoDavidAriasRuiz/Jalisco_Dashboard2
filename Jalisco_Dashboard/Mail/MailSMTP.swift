//
//  MailSMTP.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 04/04/23.
//

import Foundation
import MessageUI
import Network
import MailCore
import UIKit

struct MailSMTP {
    let subject: String
    let body: String
    
    func sendEmail(to: String) {
        // Crear el mensaje utilizando MCOMessageBuilder
        let builder = MCOMessageBuilder()
        builder.header.to = [MCOAddress(displayName: "Destinatario", mailbox: to)!]
        builder.header.from = MCOAddress(displayName: "DashBoard", mailbox: "Jalisco_Dashboard@hotmail.com")
        builder.header.subject = subject
        builder.textBody = body

        // Obtener los datos del mensaje como Data
        guard let data = builder.data() else {
            print("Error al obtener los datos del mensaje")
            return
        }
        
        print("Si se obtuvieron los datos")
        // Configurar la sesión SMTP
        let smtpSession = MCOSMTPSession()
        smtpSession.hostname = "smtp.office365.com"
        smtpSession.port = 587
        smtpSession.username = "Jalisco_Dashboard@hotmail.com"
        smtpSession.password = "dtkuejccatebgpcn"
        smtpSession.connectionType = .startTLS
        // Enviar el mensaje utilizando la sesión SMTP
        let operation = smtpSession.sendOperation(with: data)
        operation?.start { error in
            if let error = error {
                print("Error al enviar el mensaje: \(error.localizedDescription)")
            } else {
                print("Mensaje enviado con éxito")
            }
        }

    }
}
