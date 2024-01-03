//
//  UserManager.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/18.
//

import UIKit
import FirebaseAuth
import Firebase

class UserManager: ObservableObject {
    @Published var authUser: FirebaseAuth.User? = nil
    @Published var user: Contact? = nil
    @Published var isLoading: Bool = false
    @Published var isUserOnboarded: Bool = false
    @Published var isAppOnboarded: Bool = UserDefaults.standard.bool(forKey: "appOnboarded")
    
    @Published var imageUrl: URL? = nil
    
    let db = Firestore.firestore()
    let fs = FirestoreManager()
    
    func initialize() {
        self.handleUser()
    }
    
    func handleUser() {
        self.isLoading = true
        self.authUser = Auth.auth().currentUser
        if let user = authUser {
            let uid = user.uid
            let phone = user.phoneNumber ?? ""
            print(uid)
            print(phone)
            // TODO: Test it out!
            getUser(phone: phone) {
                if self.user == nil {
                    self.fs.createUser(uid: uid, phone: phone) { createdUser in
                        self.user = createdUser
                        self.isUserOnboarded = false
                        self.isLoading = false
                    }
                } else {
                    self.isUserOnboarded = true
                    print("Successfully got user from DB")
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
            if let user {
                self.imageUrl = URL(string: user.image.first ?? "")
            }
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
    
    func save(image: UIImage?, user: Contact) async throws {
        do {
            var savingUser = user
            if let image = image {
                let id = user.uid
                /// deleting old images before saving new ones
                if let path = savingUser.imagePath.first {
                    try await StorageManager.shared.deleteImage(path: path)
                }
                if let path = savingUser.smallImagePath {
                    try await StorageManager.shared.deleteImage(path: path)
                }
                let result = try await StorageManager.shared.saveProfileImage(image: image, directory: "avatars", uid: id)
                let url = try await StorageManager.shared.getUrlForImage(dir: "avatars", uid: id, path: result.name)
                let smallUrl = try await StorageManager.shared.getUrlForImage(dir: "avatars", uid: id, path: result.nameSmall)
                /// change it for multiple images. If we delete some images we also should delete paths and urls for these images
                savingUser.image = [url.absoluteString]
                savingUser.smallImage = smallUrl.absoluteString
                savingUser.imagePath = [result.path]
                savingUser.smallImagePath = result.pathSmall
                print("Image successfully saved!")
            }
            self.user = savingUser
            self.imageUrl = URL(string: savingUser.image.first ?? "")
            self.updateUser()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func signout() {
        Task {
            do {
                try Auth.auth().signOut()
                self.user = nil
                print("Successfully signed out")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func deleteUser(user: Contact? = nil) {
        if let user {
            fs.deleteUser(user: user) {
            
            }
        } else {
            if let currentUser = self.user {
                fs.deleteUser(user: currentUser) {
                    self.signout()
                }
            }
        }
    }
    
    func createUser(image: UIImage?, user: Contact, completion: @escaping (Contact?) -> Void) async throws {
        do {
            var savingUser = user
            if let image = image {
                let id = user.uid
                /// deleting old images before saving new ones
                if let path = savingUser.imagePath.first {
                    try await StorageManager.shared.deleteImage(path: path)
                }
                if let path = savingUser.smallImagePath {
                    try await StorageManager.shared.deleteImage(path: path)
                }
                let result = try await StorageManager.shared.saveProfileImage(image: image, directory: "avatars", uid: id)
                let url = try await StorageManager.shared.getUrlForImage(dir: "avatars", uid: id, path: result.name)
                let smallUrl = try await StorageManager.shared.getUrlForImage(dir: "avatars", uid: id, path: result.nameSmall)
                /// change it for multiple images. If we delete some images we also should delete paths and urls for these images
                savingUser.image = [url.absoluteString]
                savingUser.smallImage = smallUrl.absoluteString
                savingUser.imagePath = [result.path]
                savingUser.smallImagePath = result.pathSmall
                print("Image successfully saved!")
            }
            self.fs.updateUser(user: savingUser) {
                completion(savingUser)
            }
        } catch {
            completion(nil)
            print(error.localizedDescription)
        }
        
        
    }
}
