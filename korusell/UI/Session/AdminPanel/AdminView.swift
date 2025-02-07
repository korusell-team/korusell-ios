//
//  AdminView.swift
//  korusell
//
//  Created by Sergey Li on 1/2/24.
//

import SwiftUI
import PopupView
import FirebaseFirestoreSwift
import Kingfisher

struct AdminView: View {
        @EnvironmentObject var vc: SessionViewController
        @EnvironmentObject var cc: ContactsController
        @EnvironmentObject var userManager: UserManager
        @Namespace var namespace
        @State var selectedContact: Contact? = nil
        @State var popCategories = false
        @State var popSubCategories = false
        @State var popCities = false
        
        var body: some View {
            ZStack {
                VStack {
                    LabelsView(
                        popCategories: $popCategories,
                        popSubCategories: $popSubCategories
                    ).padding(.top)
                    
                    ContactListViewA(selectedContact: $selectedContact)
                }
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle("Админка")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        NavigationLink(destination: {
                            CreateUserView(user: Contact(uid: randomString(length: 24), phone: "", isPublic: false))
                        }) {
                            Image(systemName: "gear")
                                .foregroundColor(.gray900)
                        },
                    trailing:
                        ZStack {
                            if let contact = userManager.user {
                                NavigationLink(tag: contact, selection: $selectedContact, destination: {
                                    ContactDetailsViewA(user: contact)
                                }) {
                                    EmptyView()
                                }
                                .hidden()
                                
                                let url = contact.smallImage ?? ""
                                
                                KFImage.url(URL(string: url))
                                    .resizable()
                                    .placeholder {
                                        Image(systemName: "person.circle")
                                            .foregroundColor(.gray900)
                                    }
                                    .fade(duration: 1)
                                    .cancelOnDisappear(true)
                                frame(maxWidth: Size.w(25), maxHeight: Size.w(25))
                                .clipShape(Circle())
                                .background(Circle().stroke(Color.app_white, lineWidth: 3))
                                
//                                CachedAsyncImage(url: URL(string: url), urlCache: .imageCache) { phase in
//                                    switch phase {
//                                    case .empty:
//                                        Image(systemName: "person.circle")
//                                            .foregroundColor(.gray900)
//                                    case .success(let image):
//                                        image
//                                            .resizable()
//                                            .scaledToFill()
//                                        //                                        .aspectRatio(contentMode: .fit)
//                                            .frame(maxWidth: Size.w(25), maxHeight: Size.w(25))
//                                            .clipShape(Circle())
//                                            .background(Circle().stroke(Color.app_white, lineWidth: 3))
//                                            
//                                    case .failure:
//                                        Image(systemName: "person.circle")
//                                            .foregroundColor(.gray900)
//                                    @unknown default:
//                                        Image(systemName: "person.circle")
//                                            .foregroundColor(.gray900)
//                                    }
//                                }
                                .onTapGesture {
                                    self.selectedContact = userManager.user
                                }
                            }
                        }
                )
                .padding(.top, 0.1)
                .animation(.easeOut, value: cc.selectedCategory)
                .background(Color.bg)
            }
        }
    }

    struct AdminView_Previews: PreviewProvider {
        static var previews: some View {
            AdminView()
                .environmentObject(ContactsController())
        }
    }

