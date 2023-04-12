//
//  MailView.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import SwiftUI
import MessageUI

//    .sheet(isPresented: $isShowingMailView) {
//        MailView(emailModel: emailModel, isShowing: self.$isShowingMailView)
//    }

struct MailView: UIViewControllerRepresentable {
    let emailModel: EmailModel
    @Binding var isShowing: Bool

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setPreferredSendingEmailAddress(emailModel.from)
        vc.setToRecipients(emailModel.to)
        vc.setSubject(emailModel.subject)
        vc.setMessageBody(emailModel.messege, isHTML: emailModel.isHTML)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: UIViewControllerRepresentableContext<MailView>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(isShowing: $isShowing)
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var isShowing: Bool

        init(isShowing: Binding<Bool>) {
            _isShowing = isShowing
        }

        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            defer {
                isShowing = false
            }
            controller.dismiss(animated: true, completion: nil)
        }
    }
}
