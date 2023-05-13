//
//  SearchBar.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    var isEditing: FocusState<Bool>.Binding
 
    var body: some View {
        HStack {
            TextField("Поиск", text: $text, onCommit: { print(text) })
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                 
                        if isEditing.wrappedValue && !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
//                .padding(.horizontal, 10)
                .focused(isEditing)
            
            if isEditing.wrappedValue {
                Button(action: {
                    self.isEditing.wrappedValue = false
                    self.text = ""
                }) {
                    Text("Отмена")
                }
                .padding(.trailing, 10)
                .transition(.scale)
                
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical)
        .background(Color.white)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
//        SearchBar(text: .constant(""))
    }
}
