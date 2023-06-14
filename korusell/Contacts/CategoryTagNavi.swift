//
//  CategoryTagNavi.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/14.
//

import SwiftUI

struct CategoryTagNavi: View {
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace
    @Binding var searching: Bool
    var isEditing: FocusState<Bool>.Binding
    
    var body: some View {
        ZStack {
            if searching {
                SearchBar(searching: $searching, isEditing: isEditing)
            } else {
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { reader in
                            HStack(spacing: 0) {
                                ForEach(listOfCategories) { category in
                                    let selected = cc.selectedCategory == category
                                    Button(action: {
                                        withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
                                            if selected {
                                                cc.selectedCategory = nil
                                                cc.text = ""
                                            } else {
                                                cc.selectedCategory = category
                                            }
                                        }
                                    }) {
                                        VStack(spacing: 5) {
                                            Text(category.name)
                                                .foregroundColor(selected ? .gray600 : .gray400)
                                                .scaleEffect(selected ? 1.1 : 1)
                                                .font(selected ? bodyFont.bold() : bodyFont)
                                        }
                                        .padding(.vertical, 7)
                                        .padding(.horizontal, 10)
                                        .scaleEffect(cc.selectedCategory != nil && cc.selectedCategory != category ? 0.9 : 1)
                                        .id(category.name)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            
                            .onChange(of: cc.selectedCategory) { category in
                                withAnimation {
                                    if let category {
                                        reader.scrollTo(category.name, anchor: .center)
                                    } else {
                                        reader.scrollTo("Дизайн", anchor: .center)
                                    }
                                     
                                }
                            }
                        }
                    }
                    
                    if let category = cc.selectedCategory {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { reader in
                                HStack(spacing: 0) {
                                    ForEach(category.tags, id: \.self) { tag in
                                        let selected = cc.text == tag
                                        Button(action: {
                                            withAnimation {
                                                if selected {
                                                    cc.text = ""
                                                } else {
                                                    cc.text = tag
                                                }
                                            }
                                        }) {
                                            VStack(spacing: 5) {
                                                Text("#\(tag)")
                                                    .foregroundColor(selected ? .gray600 : .gray400)
                                                    .scaleEffect(selected ? 1.1 : 1)
                                                    .font(selected ? bodyFont.bold() : bodyFont)
                                            }
                                            .padding(.vertical, 5)
                                            .padding(.horizontal, 10)
                                            .scaleEffect(!cc.text.isEmpty && cc.text != tag ? 0.9 : 1)
                                            .id(tag)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .background(Color.gray10)
                                .onChange(of: cc.text) { text in
                                    withAnimation {
                                        reader.scrollTo(text, anchor: .center)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color.gray10)
    }
}

//struct CategoryTagNavi_Previews: PreviewProvider {
//    static var previews: some View {
////        CategoryTagNavi(searching: .constant(false), isEditing: <#FocusState<Bool>.Binding#>)
//    }
//}
