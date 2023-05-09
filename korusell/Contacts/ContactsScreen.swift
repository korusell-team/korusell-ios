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
                SearchBar(text: $text)
                ScrollView {
                    ForEach(filteredItem, id: \.self) { item in
                        HStack {
                            Text(item.surname)
                            Text(item.name)
                        }
                            .foregroundColor(.black)
                            .font(.body)
                            .padding()
                            .background(Color.cyan)
                    }
                }.listStyle(.grouped)
            }
             .navigationBarTitle("Контакты", displayMode: .large)
        }
    }
    
    
    var filteredItem: [Member] {
        guard !text.isEmpty else { return listOfMembers }
        
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


struct ChildView : View {
    @Environment(\.isSearching) var isSearching
    
    var body: some View {
        Text("Child")
            .onChange(of: isSearching) { newValue in
                if !newValue {
                    print("Searching cancelled")
                }
            }
    }
}
