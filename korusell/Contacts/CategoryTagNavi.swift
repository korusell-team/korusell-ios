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
    
    var body: some View {
        ZStack {
            let rows = [GridItem(.flexible())]
            
                VStack(spacing: 0) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { reader in
                            LazyHGrid(rows: rows, alignment: .top) {
                                ForEach(listOfCategories) { category in
                                    CategoryTagView(category: category)
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 40)
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
                                LazyHGrid(rows: rows, alignment: .top) {
                                    ForEach(category.tags, id: \.self) { tag in
                                        TagView(tag: tag)
                                    }
                                }
                                .padding(.horizontal)
                                .frame(height: 40)
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
        .background(Color.gray10)
    }
}

struct CategoryTagView: View {
    @EnvironmentObject var cc: ContactsController
    let category: Category
    
    var body: some View {
        let selected = cc.selectedCategory == category
        Button(action: {
            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
                if selected {
                    cc.selectedCategory = nil
                    cc.text = ""
                } else {
                    cc.selectedCategory = category
                    cc.text = ""
                }
            }
        }) {
            HStack(spacing: 5) {
                Text(category.image)
                    .font(subheadFont)
//                Image(category.image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 18, height: 18)
                Text(category.name)
                    .font(subheadFont)
            }
            .foregroundColor(selected ? .gray10 : .gray1000)
            .padding(.vertical, 7)
            .padding(.horizontal, 10)
            .background(selected ? Color.gray900 : Color.gray50)
            .cornerRadius(7, corners: [.topLeft, .bottomLeft])
            .cornerRadius(20, corners: [.topRight, .bottomRight])
            .id(category.name)
        }
    }
}

//struct CategoryTagView: View {
//    @EnvironmentObject var cc: ContactsController
//    let category: Category
//
//    var body: some View {
//        let selected = cc.selectedCategory == category
//        Button(action: {
//            withAnimation(.interpolatingSpring(stiffness: 200, damping: 20)) {
//                if selected {
//                    cc.selectedCategory = nil
//                    cc.text = ""
//                } else {
//                    cc.selectedCategory = category
//                }
//            }
//        }) {
//            VStack(spacing: 5) {
//                Text(category.name)
//                    .foregroundColor(selected ? .gray600 : .gray400)
//                    .scaleEffect(selected ? 1.1 : 1)
//                    .font(selected ? bodyFont.bold() : bodyFont)
//            }
//            .padding(.vertical, 7)
//            .padding(.horizontal, 10)
//            .scaleEffect(cc.selectedCategory != nil && cc.selectedCategory != category ? 0.9 : 1)
//            .id(category.name)
//        }
//    }
//}

struct CategoryTagNavi_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactsScreen()
            .environmentObject(cc)
    }
}
