//
//  CategoryView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct CategoryView: View {
    @Binding var searchText: String
    @Binding var selected: Category?
    
    var category: Category
    
    var body: some View {
        VStack(spacing: 10) {
            Button(action: {
                withAnimation {
                    selected = category
                    searchText = category.name
                }
            }) {
                Image(category.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding()
                    .background(Color.bg)
                    .cornerRadius(15)
                    .shadow(color: .gray50, radius: 3, x: 3, y: 3)
            }
            Text(category.name)
                .font(.footnote)
                .lineSpacing(-20)
                .foregroundColor(.gray800)
                .multilineTextAlignment(.center)
            
        }.frame(width: 95, height: 110, alignment: .top)
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(searchText: .constant(""), selected: .constant(Category(name: "", image: "")))
//        CategoryView(category: Category(name: "IT, Дизайн", image: "design"))
    }
}
