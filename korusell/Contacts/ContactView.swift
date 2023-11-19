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
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 5) {
                AvatarView(contact: contact)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(contact.surname ?? "")
                        Text(contact.name ?? "")
                    }
                    .foregroundColor(.gray1100)
                    .font(bold20f)
                    
                    
                    if let bio = contact.bio {
                        Text(bio)
                            .font(light14f)
                            .foregroundColor(.gray800)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.vertical, 5)
                    }
                    
                }
                .padding(.leading, 8)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    /// getting only sub categories
                    ForEach(contact.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                        /// matching category int with categories from db
                        let category = cc.cats.filter({ $0.id == cat }).first ??
                        Category(id: 11110, title: "bug", p_id: 1, emoji: "👾")
                        Text(category.emoji + "  " + category.title)
                            .tracking(-0.5)
                            .font(semiBold12f)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 8)
                            .overlay(
                                        Capsule(style: .continuous)
                                                .stroke(Color.gray200, lineWidth: 1)
                                    )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.vertical, 4)
                    }
                }
            }
            .foregroundColor(.gray1100)
        }
        
        .background(Color.gray10.opacity(0.1))
        .contextMenu {
              Button(action: {
                      let phone = contact.phone
                      let prefix = "tel://"
                      let phoneNumberformatted = prefix + phone
                      guard let url = URL(string: phoneNumberformatted) else { return }
                      UIApplication.shared.open(url)
                  }
              ) {
                    Text("Позвонить")
                    Image(systemName: "phone")
              }
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
