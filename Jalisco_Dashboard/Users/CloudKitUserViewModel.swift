//
//  CloudKitUser.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 29/03/23.
//

import Foundation
import CloudKit

class CloudKitUserViewModel: ObservableObject {
    
    @Published var isSignedInToiCloud: Bool = false
    @Published var error: String = ""
    
    init() {
        getCloudKitStatus()
    }
    
    private func getCloudKitStatus() {
        CKContainer.default().accountStatus { [weak self] returnedStatus, returnedError in
            DispatchQueue.main.async {
                switch returnedStatus {
                case .available: self?.isSignedInToiCloud = true
                case .noAccount: self?.error = CloudkitError.iCloudAccountNotFound.rawValue
                case .couldNotDetermine: self?.error = CloudkitError.iCloudAccountNotDetermined.rawValue
                case .restricted: self?.error = CloudkitError.iCloudAccountUnknown.rawValue
                default: self?.error = CloudkitError.iCloudAccountUnknown.rawValue
                }
            }
        }
    }
    
    enum CloudkitError: String, LocalizedError {
        case iCloudAccountNotFound
        case iCloudAccountNotDetermined
        case iCloudAccountRestricted
        case iCloudAccountUnknown
    }
}
