//
//  ContactListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct ContactListView: View {
    @EnvironmentObject var cc: ContactsController
    @State var collapsed = false
    
    var body: some View {
//        List {
            VStack(alignment: .leading, spacing: 0) {
                if !cc.filteredContacts.isEmpty {
                    ForEach(cc.filteredContacts, id: \.self) { contact in
                        ContactView(contact: contact)
//                        Divider().frame(height: 1)
                            .padding(.vertical, 7)
                    }
                } else {
                    Text("🙈 Список пуст...")
                        .foregroundColor(.gray300)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                }
            }.frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
//        }.listStyle(.grouped)
    }
}

struct ContactListView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactListView()
            .environmentObject(cc)
    }
}
