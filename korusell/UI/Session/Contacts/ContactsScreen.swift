//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI
import PopupView
import FirebaseFirestoreSwift
import CachedAsyncImage

struct ContactsScreen: View {
    @EnvironmentObject var vc: SessionViewController
    @EnvironmentObject var cc: ContactsController
    @EnvironmentObject var userManager: UserManager
    @Namespace var namespace
    
    @State var popCategories = false
    @State var popSubCategories = false
    @State var popCities = false
    
    var body: some View {
        ZStack {
            VStack {                
                LabelsView(
                    popCategories: $popCategories,
                    popSubCategories: $popSubCategories
                )
//                .padding(.top)
                
                ContactListView()
            }
            .ignoresSafeArea(edges: .bottom)
            .navigationTitle("Контакты")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading:
                    Button(action: {
                        popCities.toggle()
                    }) {
                        Image(systemName: cc.selectedCities.isEmpty ? "mappin.circle" : "mappin.circle.fill")
                            .foregroundColor(.gray900)
                    },
                
                trailing:
                    ZStack {
                        if let contact = userManager.user {
                            NavigationLink(tag: contact, selection: $cc.selectedContact, destination: {
                                ContactDetailsView(user: contact)
                            }) {
                                EmptyView()
                            }
                            .hidden()
                            
                            let url = contact.smallImage ?? ""
                            CachedAsyncImage(url: URL(string: url), urlCache: .imageCache) { phase in
                                switch phase {
                                case .empty:
                                    Image(systemName: "person.circle")
                                        .foregroundColor(.gray900)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    //                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: Size.w(25), maxHeight: Size.w(25))
                                        .clipShape(Circle())
                                        .background(Circle().stroke(Color.app_white, lineWidth: 3))
                                        
                                case .failure:
                                    Image(systemName: "person.circle")
                                        .foregroundColor(.gray900)
                                @unknown default:
                                    Image(systemName: "person.circle")
                                        .foregroundColor(.gray900)
                                }
                            }
                            .onTapGesture {
                                cc.selectedContact = userManager.user
                            }
                        }
                    }
            )
            .padding(.top, 0.1)
            .animation(.easeOut, value: cc.selectedCategory)
            .background(Color.bg)
            .popup(isPresented: $popCities) {
                PopCitiesView(popCities: $popCities)
            } customize: {
                $0
                    .type (.floater())
                    .position(.top)
                    .dragToDismiss(true)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.2))
            }
        }
    }
}

struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
            .environmentObject(ContactsController())
    }
}
