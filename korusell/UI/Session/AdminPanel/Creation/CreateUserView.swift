//
//  CreateUserView.swift
//  korusell
//
//  Created by Sergey Li on 1/3/24.
//

import SwiftUI

struct CreateUserView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var cc: ContactsController
    @State var user: Contact = Contact(uid: UUID().uuidString, phone: "", isPublic: false)
   
    @State var image: UIImage? = nil
    @State var imageUrl: URL? = nil
    
    @State var showImagePicker = false
    @State var isLoading = false
    
    var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    CreateImageView(user: $user, image: $image, imageUrl: $imageUrl, showImagePicker: $showImagePicker)
                    
                    CreateContactView(user: $user)
                        .background(Color.gray10.opacity(0.1))
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                }
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
            .background(Color.app_white)
            
            if isLoading {
                LoadingElement()
            }
        }
        .onAppear {
            self.imageUrl = URL(string: user.image.first ?? "")
        }
        
        .navigationBarItems(trailing:
            Button(action: save) {
                Text("Сохранить")}
        )
    }
    
    private func save() {
        Task {
            self.isLoading = true
            var newUser = user
            try await userManager.createUser(image: image, user: user) { user in
                if let user {
                    newUser = user
                }
            }
            if let me = cc.users.firstIndex(where: { $0.uid == newUser.uid }) {
                cc.users[me] = newUser
            } else {
                cc.users.append(newUser)
            }
            
            withAnimation {
                self.isLoading = false
            }
        }
    }
}

//#Preview {
//    CreateUserView()
//}
