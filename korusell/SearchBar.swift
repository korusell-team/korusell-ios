//
//  SearchBar.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isEditing: Bool
 
    var body: some View {
        HStack {
            TextField("Поиск", text: $text)
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
                 
                        if isEditing && !text.isEmpty {
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
                .padding(.horizontal, 10)
                .focused($isEditing)
            
            if isEditing {
                Button(action: {
                    self.isEditing = false
                    self.text = ""
 
                }) {
                    Text("Отмена")
                }
                .padding(.trailing, 10)
                .transition(.scale)
                
            }
        }.animation(.easeOut, value: isEditing)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
