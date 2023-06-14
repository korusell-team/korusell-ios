//
//  MemberListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct MemberListView: View {
    @EnvironmentObject var cc: ContactsController
    @State var collapsed = false
    
    var body: some View {
//        List {
            VStack(alignment: .leading, spacing: 0) {
                if !cc.filteredMembers.isEmpty {
                    ForEach(cc.filteredMembers, id: \.self) { member in
                        MemberView(member: member)
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

struct MemberListView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        MemberListView()
            .environmentObject(cc)
    }
}
