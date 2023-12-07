//
//  ContactDetailsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/28.
//

import SwiftUI
import CachedAsyncImage

struct ContactDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var cc: ContactsController
    
    @State var editMode: Bool = false
    
    @State var user: Contact
    @State var offset: CGFloat = 0
    @State var image: UIImage?
    @State var isLoading: Bool = false
    @State var url: URL? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                TrackableScrollView(showIndicators: false, contentOffset: $offset) {
                    if editMode {
                        EditContactImageView(user: $user, image: $image, url: $url)
                        EditContactView(user: $user)
                    } else {
                        ContactImageView(contact: user)
                        ContactDetailsInfo(contact: user)
                    }
                }
                if isLoading {
                    ProgressView()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .background(Color.app_white)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.url = URL(string: user.image.first ?? "")
        }
        .applyIf(editMode) { view in
            view
                .navigationBarItems(
                    leading: Button(action: {
                        withAnimation {
                            if let user = userManager.user {
                                self.user = user
                                self.image = nil
                            }
                            editMode = false
                        }
                    }) {
                        Text("Отмена")
                            .foregroundColor(offset > 0 ? .accentColor : .white)
                    })
        }
        .applyIf(!editMode) { view in
            view
                .navigationBarItems(
                    leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10, height: 20)
                                Text("Контакты")
                            }
                            .foregroundColor(offset > 0 ? .accentColor : .white)
                        }
                    //                        BackButton(action: { presentationMode.wrappedValue.dismiss() }, title: "Контакты")
                )
        }
        .applyIf(user.phone == userManager.user?.phone) { view in
            view.navigationBarItems(trailing:
                                        Button(action: {
                if editMode {
                    save()
                } else {
                    withAnimation {
                        editMode = true
                    }
                }
                
            }) {
                Text(editMode ? "Сохранить" : "Изменить")
                    .foregroundColor(offset > 0 ? .accentColor : .white)
            }
                .disabled(editMode && userManager.user == user && self.image == nil)
            )
        }
    }
    
    private func save() {
        Task {
            self.isLoading = true
            if let image = image, let id = user.id {
                implement multiple qualities images
                let result = try await StorageManager.shared.saveProfileImage(image: image, directory: "avatars", uid: id)
                print(result.path)
                let url = try await StorageManager.shared.getUrlForImage(dir: "avatars", uid: id, path: result.name)
                print(url.absoluteString)
                self.user.image = [url.absoluteString]
            }
            userManager.user = self.user
            userManager.updateUser()
            cc.getUsers()
            self.isLoading = false
            withAnimation {
                editMode = false
            }
        }
    }
}

//struct ContactDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ContactDetailsView(contact: dummyContacts.last(where: { $0.surname == "Мун" })!)
//        }
//    }
//}
