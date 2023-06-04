//
//  CategoriesView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct CategoryListView: View {
    @EnvironmentObject var cc: ContactsController
    @Namespace private var animation
    
    let rows = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        VStack(alignment: .center, spacing: 5) {
            Text("🔍 Категории")
                .tracking(-1)
                .foregroundColor(.gray1100)
                .font(.title3)
                .bold()
                .padding(.horizontal, 30)
                .padding(.bottom)
                .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
            
            if let selected = cc.selectedCategory {
                ZStack(alignment: .topLeading) {
                    Image(selected.image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: 225)
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
                            Button(action: cc.resetState) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                        .frame(maxWidth: UIScreen.main.bounds.width, alignment: .leading)
                        .padding(.horizontal, 30)
                        .padding(.bottom)

                        FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: selected.tags, spacing: 10, alignment: .leading) { tag in
                            TagView(tag: tag)
                        }
                        .padding(.horizontal)
                    }
                    
//                    .transition(.move(edge: .leading))
                }.frame(idealHeight: 225, maxHeight: 225, alignment: .top)
                    
                
                
            } else {
                if !cc.filteredCategories.isEmpty {
//                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHGrid(rows: rows, spacing: 0) {
                            ForEach(cc.filteredCategories, id: \.self) { category in
                                HStack {
                                    CategoryView(category: category)
                                        .matchedGeometryEffect(id: category.name, in: animation)
                                }
                                
                            }
                        }
//                    }
                    .frame(idealHeight: 225, maxHeight: 225)
                } else {
                    Text("🙈 Список пуст...")
                        .foregroundColor(.gray900)
                        .frame(maxWidth: UIScreen.main.bounds.width)
                }
            }
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        Ex()
    }
    
    static let cc = ContactsController()
    
    struct Ex: View {
        @State var text: String = "Дизайн"
        @State var cat: Category? = nil
        var body: some View {
            CategoryListView()
                .environmentObject(cc)
        }
    }
}
