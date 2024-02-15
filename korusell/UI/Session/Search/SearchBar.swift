//
//  SearchBar.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var cc: ContactsController
//    @Binding var searching: Bool
//    @Binding var searchField: String
    @Binding var searchPresented: Bool
    @FocusState var isEditing: Bool
//    var isEditing: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            TextField("Поиск", text: $cc.searchField, onCommit: {
                // TODO: Test it out!
//                cc.selectedCategory = listOfCategories.filter { $0.name.lowercased() == cc.selectedSubcategory.bound.lowercased() }.first
                })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color.gray50)
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                            .padding(.leading, 8)
                 
//                        if cc.searching && !cc.searchField.isEmpty {
//                            Button(action: {
//                                cc.searchField = ""
//                            }) {
//                                Image(systemName: "multiply.circle.fill")
//                                    .foregroundColor(.gray)
//                                    .padding(.trailing, 8)
//                            }
//                        }
                    }
                )
                .focused($isEditing)
            
//            if $isEditing.wrappedValue {
                Button(action: {
                    withAnimation {
                        searchPresented = false
                        cc.searchField = ""
                        cc.searching = false
                        cc.resetCategories()
                        $isEditing.wrappedValue = false
                    }
                }) {
                    Text("Отмена")
                }
                .padding(.trailing, 10)
                .transition(.scale)
//            }
        }
        .padding(.horizontal, 20)
        .background(Color.bg)
        .animation(.default, value: isEditing)
        .onChange(of: isEditing) { editing in
            withAnimation {
                cc.searching = editing
            }
        }
    }
}

//struct SearchBar_Previews: PreviewProvider {
//    static let cc = ContactsController()
//    
//    @FocusState var focusedField: Bool?
//    @State var searching = false
//    
//    static var previews: some View {
//        SearchBar(searching: $searching, isEditing: focusedField)
//            .environmentObject(cc)
////        SearchBar(text: .constant(""))
//    }
//}
