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
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(cc.text == tag ? Color.gray50 : Color.clear)
                    .clipShape(Capsule())
                Divider()
                    .padding(.vertical, 5)
            }
                .font(.footnote)
                .foregroundColor(cc.text == tag ? .gray1100 : .gray1000)
                .frame(height: 30)
                
                
        }
        
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                MemberView(member:
                            Member(name: "Евгений", surname: "Хан", tags: ["тамада", "ведущий", "продюсер"]))
                MemberView(member:
                            Member(name: "sdf", surname: "sf", tags: ["тамада", "ведущий"]))
                MemberView(member:
                            Member(name: "sdf", surname: "sf", tags: ["тамада", "ведущий"]))
                MemberView(member:
                            Member(name: "sdf", surname: "sf", tags: ["тамада", "ведущий"]))
            }
        }.background(Color.bg)
            .environmentObject(ContactsController())
    }
}
