//
//  Firebase.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/18.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class FirestoreManager {
    let db = Firestore.firestore()
    
    func getUserByPhone(phone: String, completion: @escaping (Contact?) -> ()) {
        print("getting user by phone")
//        let docRef = db.collection("users").document(uid)
        let docRef = db.collection("users").whereField("phone", isEqualTo: phone)
        docRef.getDocuments { (querySnapshot, error) in
            if let error = error as NSError? {
                print("Getting user error: \(error.localizedDescription)")
                completion(nil)
            } else {
                if let document = querySnapshot!.documents.first {
                    do {
                        // TODO: Need tests
                        let user = try document.data(as: Contact.self)
                        self.updateLastLogin(uid: user.uid) {
                            completion(user)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }
        }
    }
    
//    func getUser(uid: String, completion: @escaping (Contact?) -> ()) {
//        db.collection("users").document(uid).getDocument { (document, error) in
//            if let document = document, document.exists {
//                do {
//                    let user = try document.data(as: Contact.self)
//                    completion(user)
//                } catch {
//                    completion(nil)
//                }
//            } else {
//                print("User does not exist")
//            }
//        }
//    }
    
    func createUser(uid: String, phone: String, completion: @escaping (Contact) -> Void) {
        db.collection("users").document(uid).setData([
            "uid" : uid,
            "phone" : phone,
            "isPublic" : false,
            "cities": [String](),
            "image": [String](),
            "imagePath": [String](),
            "categories": [Int](),
            "updated": Date(),
            "created": Date(),
            "blockedBy": [String](),
            "reports": [String]()
        ])
        DispatchQueue.main.async {
            print("Successfully created user")
            let createdUser = Contact(uid: uid, cities: [], image: [], imagePath: [], categories: [], phone: phone, updated: Date(), created: Date(), isPublic: false, blockedBy: [], reports: [])
            completion(createdUser)
        }
    }
    
    func updateLastLogin(uid: String, completion: @escaping () -> Void) {
        db.collection("users").document(uid).updateData(["updated" : Date()])
        DispatchQueue.main.async {
            print("Successfully updated user")
            completion()
        }
    }
    
    func updateUser(user: Contact, completion: @escaping () -> Void) {
        do {
            try db.collection("users").document(user.uid).setData(from: user)
            DispatchQueue.main.async {
                print("Successfully updated user")
            }
        } catch {
            print(error)
        }
        completion()
    }
    
    func deleteUser(user: Contact, completion: @escaping () -> Void) {
        db.collection("users").document(user.uid).delete { error in
            if let error {
                print(error.localizedDescription)
            } else {
                print("User successfully deleted!")
            }
            completion()
        }
    }
    
    func reportOrBlockUser(reporter: String? = nil, blocker: String? = nil, userId: String, completion: @escaping () -> Void) {
        if let blocker {
            db.collection("users").document(userId).updateData(["blockedBy" : [blocker]])
        } else if let reporter {
            db.collection("users").document(userId).updateData(["reports" : [reporter]])
        }
            
        DispatchQueue.main.async {
            let action = reporter == nil ? "blocked" : "reported"
            print("\(userId) Successfully \(action) by \(blocker ?? reporter ?? "none")")
            completion()
        }
    }
    
    func createPlace(place: Place, completion: @escaping (Bool) -> Void) {
        do {
            try db.collection("places").document().setData(from: place)
            DispatchQueue.main.async {
                print("Successfully created place")
                completion(true)
            }
        } catch {
            print(error)
            completion(false)
        }
        completion(false)
    }
}

