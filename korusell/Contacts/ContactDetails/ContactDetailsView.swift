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
    
    @State var contact: Contact
    @State var offset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            TrackableScrollView(showIndicators: false, contentOffset: $offset) {
                ContactImageView(contact: contact)
                if editMode {
                    EditContactView(user: $contact)
                } else {
                    ContactDetailsInfo(contact: contact)
                }
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .background(Color.app_white)
        .navigationBarBackButtonHidden(true)
        .applyIf(editMode) { view in
            view
                .navigationBarItems(
                    leading: Button(action: {
                        withAnimation {
                            if let user = userManager.user {
                                self.contact = user
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
        .applyIf(contact.phone == userManager.user?.phone) { view in
            view.navigationBarItems(trailing:
                                        Button(action: {
                if editMode {
                    userManager.user = self.contact
                    userManager.updateUser()
                    withAnimation {
                        editMode = false
                    }
                } else {
                    withAnimation {
                        editMode = true
                    }
                }
                
            }) {
                Text(editMode ? "Сохранить" : "Изменить")
                    .foregroundColor(offset > 0 ? .accentColor : .white)
            }
                .opacity(editMode && userManager.user == contact ? 0.5 : 1)
                .disabled(editMode && userManager.user == contact)
            )
        }
    }
}

struct ContactImageView: View {
    @State var page: Int = 0
    
    let contact: Contact
    
    var body: some View {
        ZStack(alignment: .bottom) {
            if contact.image.isEmpty {
                ZStack(alignment: .bottom) {
                    Color.gray50
                    Image("alien")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width / 1.5)
                }
            } else {
                TabView(selection: $page) {
                    ForEach(0..<contact.image.count, id: \.self) { index in
                        CachedAsyncImage(url: URL(string: contact.image[index]), urlCache: .imageCache) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                ZStack(alignment: .top) {
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                                        .frame(height: 120)
                                }
                                .transition(.scale(scale: 0.1, anchor: .center))
                            case .failure:
                                Image(systemName: "photo")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                        .ignoresSafeArea()
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            } //else
        }
        .frame(width: UIScreen.main.bounds.width, height: Size.w(390))
        .background(Color.app_white.opacity(0.01))
        .cornerRadius(20)
    }
}

//struct ContactDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ContactDetailsView(contact: dummyContacts.last(where: { $0.surname == "Мун" })!)
//        }
//    }
//}
