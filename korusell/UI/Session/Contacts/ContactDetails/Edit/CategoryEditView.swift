//
//  CategoryEditView.swift
//  korusell
//
//  Created by Sergey Li on 12/29/23.
//

import SwiftUI

struct CategoryEditView: View {
    @Binding var user: Contact
    @State var categoriesPresented = false
    let categories: [Category]
    
    var body: some View {
        Button(action: {
            categoriesPresented = true
        }) {
            HStack(alignment: .center) {
                Text("Категория")
                    .lineLimit(1)
                    .frame(width: Size.w(90), alignment: .leading)
                /// getting only sub categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                            /// matching category int with categories from db
                            let category = categories.first(where: { $0.id == cat }) ??
                            Category(id: 11110, title: "bug", p_id: 1, emoji: "👾")
                            Text(category.title)
                                .font(regular17f)
                                .foregroundColor(.gray800)
                                .padding(.trailing, 6)
                                .onTapGesture {
                                    categoriesPresented = true
                                }
//                            Text(category.emoji + "  " + category.title)
//                                .tracking(-0.5)
//                                .font(semiBold14f)
                        }
                    }
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray800)
            }
            .foregroundColor(.gray1100)
            .background(Color.white.opacity(0.1))
            .popup(isPresented: $categoriesPresented) {
                EditCategoriesView(popCategories: $categoriesPresented, selectedCategories: $user.categories)
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .closeOnTap(false)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.4))
            }
        }
    }
}

//#Preview {
//    CategoryEditView()
//}
