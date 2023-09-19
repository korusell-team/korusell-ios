//
//  Firebase.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/18.
//

import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift

class Firebase: ObservableObject {
//    @FirestoreQuery(collectionPath: "users", predicates: [.where("uid", isEqualTo: "uid")]) var user: [Contact]
    
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
    
    func createUser(uid: String, phone: String, completion: @escaping () -> Void) {
        db.collection("users").document(uid).setData(["uid" : uid, "phone" : phone, "isPublic" : false, "cities": [String](), "image": [String](), "categories": [String](), "subcategories": [String](), "updated": Date(), "created": Date()])
        DispatchQueue.main.async {
            print("Successfully created user")
            completion()
        }
    }
    
    func updateLastLogin(uid: String, completion: @escaping () -> Void) {
        db.collection("users").document(uid).updateData(["updated" : Date()])
        DispatchQueue.main.async {
            print("Successfully updated user")
            completion()
        }
    }
    
    implement updating user for every field
    func updateUser(uid: String, date: Date, completion: @escaping () -> Void) {
        db.collection("users").document(uid).updateData(["updated" : Date()])
        DispatchQueue.main.async {
            print("Successfully updated user")
            completion()
        }
    }
}
