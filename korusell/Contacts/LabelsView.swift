//
//  CategoryTagNavi.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/14.
//

import SwiftUI

struct LabelsView: View {
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace
    
    var body: some View {
        ZStack {
            let rows = [GridItem(.flexible())]
            
                VStack(spacing: 0) {
                    /// Categories list
                    ZStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { reader in
                                LazyHGrid(rows: rows, alignment: .center) {
                                    ForEach(cc.categories, id: \.self.name) { category in
                                        Button(action: { cc.selectCategory(category: category) }) {
                                            LabelView(title: category.name, isSelected: cc.thisCategorySelected(category: category))
                                        }
                                        .id(category.name)
                                    }
                                }
                                .padding(.leading, 30)
                                .padding(.horizontal)
                                .frame(height: 40)
                                .onChange(of: cc.selectedCategory) { category in
                                    withAnimation {
                                        if let category {
                                            cc.openAllCategories = false
                                            
                                            reader.scrollTo(category.name, anchor: .center)
                                        } else {
                                            reader.scrollTo("Дизайн", anchor: .center)
                                        }
                                    }
                                }
                            }
                        }
                        
                        Button(action: {
                            cc.openAllCategories = true
                        }) {
                                Image(systemName: "magnifyingglass.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.gray900)
                                    .frame(width: 30, height: 30)
                                    .padding(4)
                                    .background(Color.bg)
                                    .cornerRadius(30)
                                    .padding(.horizontal, 5)
                        }
                    }
                    
                    /// Sub-categories list
                    if let category = cc.selectedCategory {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { reader in
                                LazyHGrid(rows: rows, alignment: .top) {
                                    ForEach(category.subCategories, id: \.self) { text in
                                        Button(action: {cc.selectSubcategory(text: text) }) {
                                            LabelView(title: text, isSelected: cc.thisSubcategorySelected(text: text))
                                        }
                                        .id(text)
                                    }
                                }
                                .padding(.horizontal)
                                .frame(height: 40)
                                .background(Color.bg)
                                .onChange(of: cc.selectedSubcategory) { text in
                                    withAnimation {
                                        reader.scrollTo(text, anchor: .center)
                                    }
                                }
                            }
                        }
                        .padding(.top, 7)
                    }
                }
        }
        .background(Color.bg)
    }
}

struct CategoryTagNavi_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactsScreen()
            .environmentObject(cc)
    }
}
