//
//  UserManager.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/18.
//

import Foundation
import FirebaseAuth
import Firebase

class UserManager: ObservableObject {
    @Published var authUser: FirebaseAuth.User? = nil
    @Published var user: Contact? = nil
    @Published var isLoading: Bool = false
    
    let db = Firestore.firestore()
    let fs = FirestoreManager()
    
    func handleUser() {
        self.isLoading = true
        self.authUser = Auth.auth().currentUser
        if let user = authUser {
            let uid = user.uid
            let phone = user.phoneNumber ?? ""
            print(uid)
            print(phone)
            
            getUser(phone: phone) {
                if self.user == nil {
                    self.fs.createUser(uid: uid, phone: phone) {
                        self.user = Contact(uid: uid, phone: phone, isPublic: false)
                        self.isLoading = false
                    }
                } else {
                    print("Successfully got user")
                    self.isLoading = false
                }
            }
        } else {
            self.isLoading = false
        }
    }
    
    func getUser(phone: String, completion: @escaping () -> ()) {
        fs.getUserByPhone(phone: phone) { user in
            self.user = user
            completion()
        }
    }
    
    func updateUser() {
        if let user {
            fs.updateUser(user: user) {
                // hanlde
            }
        }
    }
}
