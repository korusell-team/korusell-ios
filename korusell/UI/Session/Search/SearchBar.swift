//
//  SearchBar.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/09.
//

import SwiftUI

struct SearchBar: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var searchPresented: Bool
    @FocusState var isEditing: Bool
    //    var isEditing: FocusState<Bool>.Binding
    
    var body: some View {
        HStack {
            TextField("Поиск", text: $cc.searchField, onCommit: cancel)
                .id("search")
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
            Button(action: cancel) {
                Text("Отмена")
            }
            .transition(.scale)
            //            }
        }
        .padding(.horizontal, 20)
        .background(Color.bg)
        .animation(.default, value: isEditing)
        .onAppear {
            isEditing = true
        }
        .onChange(of: isEditing) { editing in
                cc.searching = editing
            if editing && cc.searchField.isEmpty {
                // MARK: refactoring
//                cc.subCategories = cc.searchCategoriesFull
            }
        }
        .onChange(of: cc.searchField) { _ in
            // MARK: refactoring
//            cc.filterBySearch()
        }
    }
    
    private func cancel() {
        withAnimation {
            searchPresented = false
            cc.searching = false
            cc.resetCategories()
            $isEditing.wrappedValue = false
            cc.searchField = ""
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
