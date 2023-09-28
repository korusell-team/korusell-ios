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
    let columns = [GridItem(.flexible())]
    @FirestoreQuery(collectionPath: "users", predicates: []) var contacts: [Contact]
    var body: some View {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 0) {
                    if !contacts.isEmpty {
                        ForEach(contacts) { contact in
                                ContactView(contact: contact)
                                    .padding(.vertical, 7)
                            }
                        } else {
                            Text("🙈 Список пуст...")
                                .foregroundColor(.gray300)
                                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer(minLength: 200)
            }
            .padding(.top, 35)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.white)
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
