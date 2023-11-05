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
        HStack(alignment: .top, spacing: 5) {
            AvatarView(contact: contact)
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text(contact.surname ?? "")
                    Text(contact.name ?? "")
                }
                .foregroundColor(.gray1100)
                .font(bold20f)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 0) {
                        ForEach(contact.categories, id: \.self) { cat in
                            let category = cc.cats.filter({ $0.id == cat }).first!
                            Text(category.title)
                                .padding(3)
                                .font(category.p_id > 0 ? light14f : semiBold16f)
//                                .background(category.p_id > 0 ? Color.clear : Color.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 25))
//                                .shadow(color: Color.gray200.opacity(0.2), radius: 2, x: 2, y: 2)
                                .padding(.vertical, 4)
                        }
                    }
                }
                .foregroundColor(.gray1000)
                
                
                if let bio = contact.bio {
                    Text(bio)
                        .font(light14f)
                        .foregroundColor(.gray800)
                        .multilineTextAlignment(.leading)
                        .lineLimit(2)
                        .padding(.top, 4)
                }
            }
            .padding(.leading, 8)
        }
        .background(Color.gray10.opacity(0.1))
    }
}

struct ContactView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactListView()
            .environmentObject(cc)
    }
}
