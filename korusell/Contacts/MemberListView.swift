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
        VStack(alignment: .leading, spacing: 5) {
//            Button(action: {
//                withAnimation {
//                    collapsed.toggle()
//                }
//            }) {
//            HStack {
//                Text("👨🏻‍💻 Люди")
//                    .tracking(-1)
//                    .font(.title3)
//                    .bold()
//                    .padding(.bottom)
//                Spacer()
//
//                    Image(systemName: "chevron.down")
//                        .rotationEffect(Angle(degrees: collapsed ? 180 : 0))
//                }
//            .foregroundColor(.gray1100)
//            .padding(.horizontal, 30)
//            .contentShape(Rectangle())
//            .onTapGesture {
//                withAnimation {
//                    collapsed.toggle()
//                }
//            }
//            }
            
//            if !collapsed {
                if !cc.filteredMembers.isEmpty {
                    ForEach(cc.filteredMembers, id: \.self) { member in
                        MemberView(member: member)
                    }
                } else {
                    Text("🙈 Список пуст...")
                        .foregroundColor(.gray900)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                }
//            }
        }.frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
    }
}

struct MemberListView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
            MemberListView()
                .environmentObject(cc)
    }
}
