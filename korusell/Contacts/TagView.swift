//
//  TagView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct TagView: View {
    @EnvironmentObject var cc: ContactsController
    var tag: String
    
    var body: some View {
        Button(action: {
            cc.text = cc.text == tag ? "" : tag
        }) {
            HStack {
                Text(tag.uppercased())
                    .font(caption2Font)
                    .foregroundColor(.gray10)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color.gray900)
                    .clipShape(Capsule())
                
            }
                .font(.footnote)
                .foregroundColor(cc.text == tag ? .gray1100 : .gray1000)
                .frame(height: 30)
                
                
        }
        
    }
}

struct TagView_Previews: PreviewProvider {
    static let cc = ContactsController()
    static var previews: some View {
        NavigationView {
            ContactDetailsView(contact: listOfContacts.first(where: { $0.name == "Владимир" })!)
                .environmentObject(cc)
        }
    }
}
