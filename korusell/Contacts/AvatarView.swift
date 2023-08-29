//
//  AvatarView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/11.
//

import SwiftUI

struct AvatarView: View {
//    @State var image: UIImage?
    @State private var showSheet = false
    @State private var showAlert = false
    
    let contact: Contact
    var messages: Int = 0

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray900)
                .frame(width: 55, height: 55)
            Text(String(contact.name.capitalized.first!))
                .font(title2Font)
                .foregroundColor(.white)
            + Text(String(contact.surname.capitalized.first!))
                .font(title2Font)
                .foregroundColor(.white)
            
            // TODO: redo after DB
            if !contact.image.isEmpty {
                Image(contact.image.first!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .frame(width: 55, height: 55)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
        }.frame(width: 55, height: 55)
         .clipShape(Circle())
         .contentShape(ContentShapeKinds.contextMenuPreview, Circle())
         .overlay(
            messagesView
         )
    }
    
    var messagesView: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 18, height: 18)
            Text(String(messages))
                .foregroundColor(.white)
                .font(.footnote)
        }.offset(x: 23, y: -13.5)
         .opacity(messages > 0 ? 1 : 0)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactsScreen()
            .environmentObject(cc)
    }
    
}

struct DetailsAvatarView: View {
    let contact: Contact

    var body: some View {
        let frame: CGFloat = contact.image.isEmpty ? 70 : 100
        ZStack {
            Circle()
                .fill(Color.gray900)
                .frame(width: 100, height: 100)
            Text(String(contact.name.capitalized.first!))
            + Text(String(contact.surname.capitalized.first!))
            
            // TODO: redo after DB
            if !contact.image.isEmpty {
                Image(contact.image.first!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
        }
        .font(largeTitleFont)
        .foregroundColor(.white)
        .frame(width: frame, height: frame)
        .clipShape(Circle())
        .contentShape(ContentShapeKinds.contextMenuPreview, Circle())
    }
}
