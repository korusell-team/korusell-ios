//
//  MemberListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct MemberListView: View {
    @EnvironmentObject var cc: ContactsController
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("👨🏻‍💻 Люди")
                .tracking(-1)
                .foregroundColor(.gray1100)
                .font(.title3)
                .bold()
                .padding(.horizontal, 30)
                .padding(.bottom)
            if !cc.filteredMembers.isEmpty {
                ForEach(cc.filteredMembers, id: \.self) { member in
                    MemberView(member: member)
                }
            } else {
                Text("🙈 Список пуст...")
                    .foregroundColor(.gray900)
                    .frame(maxWidth: .infinity)
            }
        }.frame(maxWidth: .infinity)
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
//        ContactsScreen()
        Ex()
    }
    
    struct Ex: View {
        @State var text: String = "с"
        var body: some View {
            MemberListView()
        }
    }
}
