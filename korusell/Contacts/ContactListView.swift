//
//  ContactListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ContactListView: View {
    @EnvironmentObject var cc: ContactsController
    @State var collapsed = false
    @State var selectedContact: Contact? = nil
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        List {
            if cc.contacts.isEmpty && cc.selectedCategory == nil && cc.selectedSubcategory == nil {
                VStack(spacing: 15) {
                    Text("🙈 Список пуст...")
                    Text("Потяни 👇 вниз чтобы обновить")
                }
                .foregroundColor(.gray300)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.app_white)
            } else if cc.contacts.isEmpty && (cc.selectedCategory != nil || cc.selectedSubcategory != nil) {
                Text("🙈 Список пуст...")
                    .foregroundColor(.gray300)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.app_white)
            } else {
                ForEach(cc.contacts) { contact in
                    ZStack {
                        NavigationLink(tag: contact, selection: $selectedContact, destination: {
                            ContactDetailsView(user: contact)
                        }) {
                            EmptyView()
                        }
                        .hidden()
                        ContactView(contact: contact)
                    }
                    .listRowBackground(Color.app_white)
                    .onTapGesture {
                        self.selectedContact = contact
                    }
                }
                
                Spacer(minLength: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.app_white)
            }
        }
        .listStyle(.plain)
        .refreshable {
            if cc.selectedCategory == nil {
                cc.getCats()
                cc.getUsers()
                print("refreshing...")
            }
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.app_white)
        .cornerRadius(30, corners: [.topLeft, .topRight])
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        //        ContactListView()
        ContactsScreen()
            .environmentObject(ContactsController())
    }
}
