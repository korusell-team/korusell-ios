//
//  TagView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct TagView: View {
    @EnvironmentObject var cc: ContactsController
    let tag: String
    
    var body: some View {
        let selected = cc.text == tag
        Button(action: {
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
                if selected {
                    cc.text = ""
                } else {
                    cc.text = tag
                }
                cc.openAllCategories = false
            }
        }) {
            Text(tag)
                .font(subheadFont)
                .foregroundColor(selected ? .gray10 : .gray1000)
                .padding(.vertical, 7)
                .padding(.horizontal, 10)
                .background(selected ? Color.gray900 : Color.gray50)
                .cornerRadius(7, corners: [.topLeft, .bottomLeft])
                .cornerRadius(20, corners: [.topRight, .bottomRight])
                .id(tag)
        }
    }
}

//struct TagView: View {
//    @EnvironmentObject var cc: ContactsController
//    var tag: String
//
//    var body: some View {
//        Button(action: {
//            cc.text = cc.text == tag ? "" : tag
//        }) {
//            Text(tag)
//                .font(subheadFont)
//                .foregroundColor(.gray1000)
//                .padding(.vertical, 7)
//                .padding(.horizontal, 10)
//                .background(Color.gray50)
//                .cornerRadius(20)
//                .padding(.horizontal, 5)
//                .id(tag)
//            //                .frame(height: 30)
//        }
//    }
//}

struct TagView_Previews: PreviewProvider {
    static let cc = ContactsController()
    static var previews: some View {
        NavigationView {
            ContactDetailsView(contact: listOfContacts.first(where: { $0.name == "Владимир" })!)
                .environmentObject(cc)
        }
    }
}
