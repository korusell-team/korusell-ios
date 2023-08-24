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
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView(showsIndicators: false) {
                LazyVGrid(columns: columns, spacing: 0, pinnedViews: .sectionHeaders) {
                    VStack(alignment: .leading, spacing: 0) {
                        if !cc.filteredContacts.isEmpty {
                            ForEach(cc.filteredContacts, id: \.self) { contact in
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
                }
            }
            .padding(.top, 35)
        }
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
