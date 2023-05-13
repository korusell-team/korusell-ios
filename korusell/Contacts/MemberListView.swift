//
//  MemberListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct MemberListView: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("👨🏻‍💻 Люди")
                .tracking(-1)
                .foregroundColor(.gray1100)
                .font(.title3)
                .bold()
                .padding(.horizontal, 30)
                .padding(.bottom)
            if !filteredMembers.isEmpty {
                ForEach(filteredMembers, id: \.self) { member in
                    MemberView(searchText: $searchText, member: member)
                }
            } else {
                Text("🙈 Список пуст...")
                    .foregroundColor(.gray900)
                    .frame(maxWidth: .infinity)
            }
        }.frame(maxWidth: .infinity)
    }

    var filteredMembers: [Member] {
        guard !searchText.isEmpty else { return listOfMembers.sorted(by: { $0.surname < $1.surname}) }
        
        return listOfMembers.filter { member in
            member.name.lowercased().contains(searchText.lowercased()) ||
            member.surname.lowercased().contains(searchText.lowercased()) ||
            !member.tags.filter { $0.lowercased().contains(searchText.lowercased()) }.isEmpty
        }.sorted(by: { $0.surname < $1.surname})
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
            MemberListView(searchText: $text)
        }
    }
}
