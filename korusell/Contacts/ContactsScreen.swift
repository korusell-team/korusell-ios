//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

struct ContactsScreen: View {
    @State var text = ""

    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    SearchBar(text: $text)
                        .padding()
                    let columns = [GridItem(.flexible()), GridItem(.flexible())]
                    LazyVGrid(columns: columns, spacing: 8) {
                        ForEach(filteredItem, id: \.self) { member in
                            MemberView(member: member)
                        }
                    }.padding(.horizontal, 10)
                }
            }
             .navigationBarTitle("Контакты", displayMode: .large)
        }
    }
    
    
    var filteredItem: [Member] {
        guard !text.isEmpty else { return listOfMembers.sorted(by: { $0.surname < $1.surname}) }
        
        return listOfMembers.filter { item in
            item.name.lowercased().contains(text.lowercased()) ||
            item.surname.lowercased().contains(text.lowercased())
        }
    }
}



struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
        
    }
}
