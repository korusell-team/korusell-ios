//
//  PopCategoriesView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/23.
//

import SwiftUI

struct PopCategoriesView: View {
    @EnvironmentObject var cc: ContactsController
    
    var body: some View {
        VStack(spacing: 0) {
            Text("КАТЕГОРИИ")
                .foregroundColor(.gray1000)
                .font(headlineFont)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 22)
                .padding(.top, 22)
            
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.categories, spacing: 10, alignment: .leading) { category in
                Button(action: { cc.selectCategory(category: category) }) {
                    LabelView(title: category.name, isSelected: cc.thisCategorySelected(category: category))
                }
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
        .cornerRadius(30)
        .padding(.horizontal, 22)
    }
}

struct PopCategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PopCategoriesView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray100)
        .environmentObject(ContactsController())
    }
}
