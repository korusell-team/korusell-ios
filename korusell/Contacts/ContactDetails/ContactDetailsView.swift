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
    @Namespace private var animation
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                if editMode {
                    List {
                        Section {
                            EditContactImageView(user: $user, image: $image, url: $url, animation: animation)
                                .listRowSeparator(.hidden)
                        }
                        .listRowInsets(EdgeInsets())
                        .background(Color(UIColor.systemGroupedBackground))
//                        ) {}.textCase(nil)
                        
                        EditContactView(user: $user)
                    }
                } else {
                    TrackableScrollView(showIndicators: false, contentOffset: $offset) {
                        ContactImageView(contact: user, animation: animation)
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
                    Task {
                        self.isLoading = true
                        try await userManager.save(image: image, user: user)
                        cc.getUsers()
                        withAnimation {
                            self.isLoading = false
                            editMode = false
                        }
                    }
                } else {
                    withAnimation {
                        editMode = true
                    }
                }
            }) {
                Text(editMode ? "Готово" : "Изменить")
                    .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
            }
                .disabled(editMode && userManager.user == user && self.image == nil)
            )
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
