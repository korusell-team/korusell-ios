//
//  CategoriesView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct CategoryListView: View {
    @Namespace private var animation
    @Binding var searchText: String
    @Binding var selected: Category?
    
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("🔍 Категории")
                .tracking(-1)
                .foregroundColor(.gray1100)
                .font(.title3)
                .bold()
                .padding(.horizontal, 30)
                .padding(.bottom)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if let selected {
                ZStack(alignment: .topLeading) {
                    Image(selected.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity, maxHeight: 225)
                        .opacity(0.2)
                        .matchedGeometryEffect(id: selected.name, in: animation)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Image(selected.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 15, height: 15)
                            Text(selected.name)
                                .font(.footnote)
                                .lineSpacing(-20)
                                .foregroundColor(.gray800)
                                .multilineTextAlignment(.center)
                            Button(action: {
                                withAnimation {
                                    self.selected = nil
                                    self.searchText = ""
                                }
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 30)
                        .padding(.bottom)

                        FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: selected.tags, spacing: 10, alignment: .leading) { tag in
                            TagView(tag: tag, secondText: $searchText)
                        }
                        .padding(.horizontal)
                    }
                    
//                    .transition(.move(edge: .leading))
                }.frame(idealHeight: 225, maxHeight: 225, alignment: .top)
                    
                
                
            } else {
                if !filteredCategories.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 0) {
                            ForEach(filteredCategories, id: \.self) { category in
                                HStack {
                                    CategoryView(searchText: $searchText, selected: $selected, category: category)
                                        .matchedGeometryEffect(id: category.name, in: animation)
                                }
                                
                            }
                        }
                    }
                    .frame(idealHeight: 225, maxHeight: 225)
//                    .transition(.move(edge: .trailing))
                } else {
                    Text("🙈 Список пуст...")
                        .foregroundColor(.gray900)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
    
    var filteredCategories: [Category] {
        guard !searchText.isEmpty else { return listOfCategories }
        
        return listOfCategories.filter { category in
            category.name.lowercased().contains(searchText.lowercased()) ||
            !category.tags.filter { $0.lowercased().contains(searchText.lowercased()) }.isEmpty
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Ex()
    }
    
    struct Ex: View {
        @State var text: String = "Дизайн"
        @State var cat: Category? = nil
        var body: some View {
            CategoryListView(searchText: $text, selected: $cat)
        }
    }
}
