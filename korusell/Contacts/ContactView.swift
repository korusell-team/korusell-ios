//
//  ContactView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/10.
//

import SwiftUI

struct ContactView: View {
    @EnvironmentObject var cc: ContactsController
    
    @State var marked = false
    @State var liked = false
    @State var connectOpened = false
    @State var isPresentInfo = false
    
    let contact: Contact
    
    var body: some View {
        NavigationLink(destination: {
            ContactDetailsView(contact: contact)
        }) {
            HStack(alignment: .center, spacing: 5) {
                AvatarView(contact: contact)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(contact.surname)
                        Text(contact.name)
                    }
                    .foregroundColor(.gray1100)
                    .font(title3Font)
                    
                    HStack(spacing: 10) {
                        Text(contact.categories.first ?? "")
//                        Image(systemName: "chevron.right")
//                            .font(footnoteFont)
                        Text("•")
                        Text(contact.subcategories.first ?? "")
                    }
                        .font(subheadFont)
                        .foregroundColor(.gray800)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 2)
                        .padding(.bottom, 14)
                    
                    
                    Divider()
                }
                .padding(.leading, 8)
            }
            .padding(.horizontal)
            .padding(.horizontal, 10)
        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
            ContactListView()
                .environmentObject(cc)
    }
}
