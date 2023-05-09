//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

struct ContactsScreen: View {
    @Environment(\.dismissSearch) var dismissSearch
    @State var text = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(listOfMembers.filter {
                        $0.name.localizedCaseInsensitiveContains(text) ||
                        $0.surname.localizedCaseInsensitiveContains(text) }, id: \.self) { item in
                            
                        HStack {
                            Text(item.surname)
                            Text(item.name)
                        }
                            .foregroundColor(.black)
                            .font(.body)
                    }
                }
            }
            
             .navigationBarTitle("Контакты", displayMode: .large)
             .searchable(text: $text, prompt: "Поиск")
        }
        
//        .searchable(text: $text, prompt: "Поиск", suggestions: {
//            let textArray = text.components(separatedBy: " ")
//
//            ForEach(filteredItem, id: \.self) { suggestion in
//                    HStack {
//                        Text(suggestion.surname)
//                        Text(suggestion.name)
//                    }
//                        .foregroundColor(.black)
//                        .font(.body)
//                        .searchCompletion(suggestion.description)
//                 }
//        })
    }
    
    
    var filteredItem: [Member] {
        guard !text.isEmpty else { return listOfMembers }
        
        return listOfMembers.filter { item in
            item.name.lowercased().contains(text.lowercased())
        }
    }
}



struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
        
    }
}
