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
    @EnvironmentObject var vc: SessionViewController
    @EnvironmentObject var cc: ContactsController
    
    @State var editMode: Bool = false
    
    @Binding var outerUser: Contact
    @State var user: Contact
    
    @State var offset: CGFloat = 0
    @State var image: UIImage?
    @State var isLoading: Bool = false
    //
    //    @State var url: URL? = nil
    @Namespace private var animation
    
    @State var showAlert: Bool = false
    @State var showBlock: Bool = false
    @State var showReport: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if editMode {
                    EditDetailsView(user: $user, image: $image, showAlert: $showAlert, animation: animation)
                } else {
                    TrackableScrollView(showIndicators: false, contentOffset: $offset) {
                        ContactImageView(user: $user, animation: animation)
                        ContactDetailsInfo(contact: user)
                    }
                }
                
                if isLoading {
                    LoadingElement()
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .background(Color.app_white)
        .navigationBarBackButtonHidden(true)
        .alertPatched(isPresented: $showBlock) {
            Alert(title: Text("Блокировка Пользователя"), message:
                    Text("Вы уверены что хотите заблокировать Пользователя?"),
                  primaryButton: .destructive(Text("Заблокировать"), action: {
                if let uid = userManager.user?.uid {
                    userManager.blockOrReport(blocker: uid, userId: user.uid) {
                        cc.contacts.removeAll(where: { $0.uid ==  user.uid})
                    }
                }
            }),
                  secondaryButton: .cancel(Text("Отмена"), action: {
                showBlock = false
            }))
        }
        .alertPatched(isPresented: $showReport) {
            Alert(title: Text(""), message:
                    Text("Вы уверены что хотите пожаловаться на Пользователя?"),
                  primaryButton: .destructive(Text("Пожаловаться"), action: {
                if let uid = userManager.user?.uid {
                    userManager.blockOrReport(reporter: uid, userId: user.uid) {
                        cc.contacts.removeAll(where: { $0.uid ==  user.uid})
                    }
                }
            }),
                  secondaryButton: .cancel(Text("Отмена"), action: {
                showReport = false
            }))
        }
        .onAppear {
            self.user = self.outerUser
            withAnimation {
                vc.showBottomBar = false
            }
        }
        .onDisappear {
            self.outerUser = self.user
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
                            .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
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
                            .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
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
                    .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
            }
                .disabled(editMode && userManager.user == user && self.image == nil)
            )
        }
        .applyIf(user.phone != userManager.user?.phone) { view in
            view.navigationBarItems(trailing:
                                        HStack {
                Button(action: {
                    userManager.like(user: user) {
                        withAnimation(.bouncy) {
                            if let myUid = userManager.user?.uid {
                                if user.likes.contains(myUid) {
                                    user.likes.removeAll(where: { $0 == myUid })
                                } else {
                                    user.likes.append(myUid)
                                }
                            }
                        }
                    }
                }) {
                    let liked = user.likes.contains(userManager.user?.uid ?? "")
                    Image(systemName: liked ? "heart.fill" : "heart")
                        .foregroundColor(liked ? .red : .white)
                }
                
                Menu {
                    Button(action: {
                        showBlock = true
                    }) {
                        Label("Заблокировать", systemImage: "hand.raised")
                    }.tint(.orange)
                    
                    Button(action: {
                        showReport = true
                    }) {
                        Label("Пожаловаться", systemImage: "exclamationmark.bubble")
                    }.tint(.red)
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
                }
            }
                                    
            )
        }
    }
    
    private func save() {
        if user.isPublic {
            if user.image.isEmpty && image == nil {
                showAlert = true
                return
            }
            if user.name == nil || user.name?.isEmpty ?? true {
                showAlert = true
                return
            }
            if user.categories.isEmpty {
                showAlert = true
                return
            }
            if user.bio?.isEmpty ?? true {
                showAlert = true
                return
            }
        }
        Task {
            self.isLoading = true
            try await userManager.save(image: image, user: user)
            // MARK: Applying changes inside contacts list
            if let me = cc.contacts.firstIndex(where: { $0.uid == user.uid }) {
                cc.contacts[me] = user
            }
            withAnimation {
                //                self.url = URL(string: userManager.user?.image.first ?? "")
                self.isLoading = false
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
