//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

struct ContactsScreen: View {
    @State var text = ""
    
    let list: [Item] = [
        Item(name: "Евгений", surname: "Ким"),
        Item(name: "Сергей", surname: "Ли"),
        Item(name: "Антон", surname: "Емельянов"),
        Item(name: "Андрей", surname: "Ким"),
        Item(name: "Владимир", surname: "Мун"),
        Item(name: "Вероника", surname: "Мун")
    ]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(list.filter {
                    $0.name.localizedCaseInsensitiveContains(text) ||
                    $0.surname.localizedCaseInsensitiveContains(text) }, id: \.self) { item in
                        
                    HStack {
                        Text(item.surname)
                        Text(item.name)
                    }
                        .foregroundColor(.black)
                        .font(.body)
                }
            }.padding()
             .navigationBarTitle("Контакты", displayMode: .large)
        }.searchable(text: $text, prompt: "Поиск", suggestions: {
            let textArray = text.components(separatedBy: " ")
            
            
            
            ForEach(filteredItem, id: \.self) { suggestion in
                    HStack {
                        Text(suggestion.surname)
                        Text(suggestion.name)
                    }
                        .foregroundColor(.black)
                        .font(.body)
                        .searchCompletion(suggestion.description)
                 }
        })
    }
    //test
    var filteredItem: [Item] {
        
            guard !text.isEmpty else { return list }
            
        
            return list.filter { item in
                item.name.lowercased().contains(text.lowercased())
            }
        }
}

struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
            
    }
}

struct Item: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let surname: String
    
    var description: String {
        return self.surname + " " + self.name
    }
}
