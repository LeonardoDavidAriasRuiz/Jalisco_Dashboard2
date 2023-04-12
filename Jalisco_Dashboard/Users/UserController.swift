//
//  CustomUserController.swift
//  Jalisco_Dashboard
//
//  Created by Leonardo David Arias Ruiz on 30/03/23.
//

import SwiftUI
import CloudKit

class UserController: ObservableObject {
    
    private let customUsersRecordType = "CustomUsers"
    private let userIdField = "id"
    private let userNameField = "name"
    private let userLastNameField = "lastName"
    private let userEmailField = "email"
    private let userPinField = "pin"
    private let userRestaurantsField = "restaurants"
    
    private let restaurantesRecordType = "Restaurantes"
    private let restaurantNameField = "name"
    private let restaurantLinkAdminField = "linkAdmin"
    private let restaurantLinkEmployeeField = "linkEmployee"
    private let linkAdminNoAllowed = "Vínculo Admin no permitido"
    
    // Published properties to track the user's iCloud account and authentication status, as well as other data
    @Published var isiCloudUser: Bool = false
    @Published var isUserLogIn: Bool = false
    @Published var isUserSignIn: Bool = false
    @Published var isUserLinked: Bool = false
    
    @Published private var userId: String? = nil
    
    @Published var userRecord: CKRecord? = nil
    @Published var userModel: CustomUserModel = CustomUserModel()
    @Published var restaurantes: [RestauranteModel] = []
    @Published var queriesDone: Bool = false
    @Published var currentRestaurantLink: String = ""
    @Published var currentRestaurantAdmin: Bool = false
    
    // Initializer that checks the user's iCloud account status, gets their CloudKit user ID, and checks if they are logged in
    init() {
        checkiCloudUser()
    }
    
    // Function to add a new user to the CloudKit database
    func addUser(user: CustomUserModel) {
        let newUser = CKRecord(recordType: customUsersRecordType)
        newUser[userIdField] = userId
        newUser[userNameField] = user.name
        newUser[userLastNameField] = user.lastName
        newUser[userEmailField] = user.email
        newUser[userPinField] = user.pin
        newUser[userRestaurantsField] = user.restaurants
        
        saveRecord(newUser)
        
    }
    
    func saveRestaurantInUser() {
        userRecord?[userRestaurantsField] = userModel.restaurants
        
        saveRecord(userRecord ?? CKRecord(recordType: customUsersRecordType))
        userModel = userModel
    }
    
    private func saveRecord(_ record: CKRecord) {
        CKContainer.default().publicCloudDatabase.save(record) { (record, _) in
            guard let _ = record else { return }
            self.loadUserInfo()
        }
    }
    
    // Private function to check if the user has an iCloud account
    private func checkiCloudUser() {
        CKContainer.default().accountStatus { (status, _) in
            guard case .available = status else { return }
            DispatchQueue.main.async {
                self.isiCloudUser = true
                self.loadUserInfo()
            }
        }
    }
    
    // Private function to get the user's CloudKit user ID
    func loadUserInfo() {
        CKContainer.default().fetchUserRecordID { (id, _) in
            guard let id = id else { return }
            DispatchQueue.main.sync {
                self.userId = id.recordName
            }
            self.checkIfLoggedIn()
        }
    }
    
    // Private function to check if the user is logged in and retrieve their data if they are
    private func checkIfLoggedIn() {
        guard let id = userId else {
            self.queriesDone = true
            return
        }
        let predicate = NSPredicate(format: "\(userIdField) == %@", id)
        let query = CKQuery(recordType: customUsersRecordType, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (_, result) in
            guard case .success(let record) = result,
               let name: String = record[self.userNameField],
               let lastName: String = record[self.userLastNameField],
               let email: String = record[self.userEmailField],
               let pin: String = record[self.userPinField],
               let restaurants: [String] = record[self.userRestaurantsField] else { return }
            DispatchQueue.main.async {
                self.isUserLogIn = true
                self.userRecord = record
                self.userModel = CustomUserModel(name: name, lastName: lastName, email: email, pin: pin, restaurants: restaurants)
                self.getRestaurantsList()
            }
        }
        addQueryOperation(queryOperation)
    }
    
    /**
     Fetches the list of restaurants from the CloudKit public database and appends them to the restaurantes array if they belong to the user's list of restaurants.
     */
    private func getRestaurantsList() {
        DispatchQueue.main.async {
            self.restaurantes = []
        }
        let predicateA = NSPredicate(format: "\(restaurantLinkAdminField) IN %@", userModel.restaurants)
        let predicateE = NSPredicate(format: "\(restaurantLinkEmployeeField) IN %@", userModel.restaurants)
        handleRecord(predicate: predicateA)
        handleRecord(predicate: predicateE)
        
        func handleRecord(predicate: NSPredicate) {
            let query = CKQuery(recordType: restaurantesRecordType, predicate: predicate)
            let queryOperation = CKQueryOperation(query: query)
            
            queryOperation.recordMatchedBlock = { (_, result) in
                print("sdfv")
                guard case .success(let record) = result,
                      let name: String = record[self.restaurantNameField],
                      let linkAdmin: String = record[self.restaurantLinkAdminField],
                      let linkEmployee: String = record[self.restaurantLinkEmployeeField] else { return }
                DispatchQueue.main.sync {
                    var restaurant = RestauranteModel()
                    if self.userModel.restaurants.contains(linkAdmin) {
                        restaurant = RestauranteModel(name: name, linkAdmin: linkAdmin, linkEmployee: linkEmployee)
                        self.currentRestaurantAdmin = true
                    } else if self.userModel.restaurants.contains(linkEmployee) {
                        restaurant = RestauranteModel(name: name, linkEmployee: linkEmployee)
                        self.currentRestaurantAdmin = false
                    }
                    
                    self.restaurantes.append(restaurant)
                    self.restaurantes = self.restaurantes
                }
            }
            
            queryOperation.queryResultBlock = { result in
                DispatchQueue.main.async {
                    self.queriesDone = true
                }
            }
            addQueryOperation(queryOperation)
        }
    }
    
    func setCurrentRestaurant(restaurant: RestauranteModel) {
        let linkAdmin = restaurant.linkAdmin
        let linkEmployee = restaurant.linkEmployee
        let predicate = restaurant.linkAdmin == linkAdminNoAllowed ? NSPredicate(format: "\(restaurantLinkEmployeeField) == %@", linkEmployee) : NSPredicate(format: "\(restaurantLinkAdminField) == %@", linkAdmin)
        let query = CKQuery(recordType: restaurantesRecordType, predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        queryOperation.recordMatchedBlock = { (_, result) in
            guard case .success(let record) = result,
                    let link: String = record[self.restaurantLinkAdminField] else { return }
            DispatchQueue.main.async {
                self.currentRestaurantLink = link
                self.currentRestaurantAdmin = (link == linkAdmin)
            }
        }
        addQueryOperation(queryOperation)
        
    }
    
    func addQueryOperation(_ qo: CKQueryOperation) {
        CKContainer.default().publicCloudDatabase.add(qo)
    }
}

