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
        ZStack {
            NavigationLink(destination: ContactDetailsView(contact: contact)) {
                EmptyView()
            }
            .buttonStyle(PlainButtonStyle())
            
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
                                    .padding(6)
                                    .background(category.p_id > 0 ? Color.clear : Color.gray50)
                                    .clipShape(RoundedRectangle(cornerRadius: 25))
                                    .font(category.p_id > 0 ? regular13f : bold14f)
                            }
                        }
                    }
                    .foregroundColor(.gray800)
                    .padding(.top, 2)
                    
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
            .background(Color.white)
        }
        
        //        NavigationLink(destination: {
        //            ContactDetailsView(contact: contact)
        //        }) {
        //            HStack(alignment: .top, spacing: 5) {
        //                AvatarView(contact: contact)
        //
        //                VStack(alignment: .leading, spacing: 0) {
        //                    HStack {
        //                        Text(contact.surname ?? "")
        //                        Text(contact.name ?? "")
        //                    }
        //                    .foregroundColor(.gray1100)
        //                    .font(bold20f)
        //
        //                    ScrollView(.horizontal, showsIndicators: false) {
        //                        HStack(spacing: 0) {
        //                            ForEach(contact.categories, id: \.self) { cat in
        //                                let category = cc.cats.filter({ $0.id == cat }).first!
        //                                Text(category.title)
        //                                    .padding(6)
        //                                    .background(category.p_id > 0 ? Color.clear : Color.gray50)
        //                                    .clipShape(RoundedRectangle(cornerRadius: 25))
        //                                    .font(category.p_id > 0 ? regular13f : bold14f)
        //                            }
        //                        }
        //                    }
        //                        .foregroundColor(.gray800)
        //                        .padding(.top, 2)
        //
        //                    if let bio = contact.bio {
        //                        Text(bio)
        //                            .font(light14f)
        //                            .foregroundColor(.gray800)
        //                            .multilineTextAlignment(.leading)
        //                            .lineLimit(2)
        //                            .padding(.top, 4)
        //                    }
        //
        ////                    Divider()
        ////                        .padding(.top, 10)
        //                }
        //                .padding(.leading, 8)
        //            }
        //            .padding(.horizontal)
        //            .padding(.horizontal, 10)
        //        }
    }
}

struct ContactView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactListView()
            .environmentObject(cc)
    }
}
