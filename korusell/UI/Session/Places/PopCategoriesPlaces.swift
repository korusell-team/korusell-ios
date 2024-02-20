//
//  PopCategoriesPlaces.swift
//  korusell
//
//  Created by Sergey Li on 1/25/24.
//

import SwiftUI

struct PopCategoriesPlaces: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCategories: Bool
    @Binding var selectedCategory: Category?
    var reader: ScrollViewProxy? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("КАТЕГОРИИ")
                    .font(bold17f)
                    .bold()
                Spacer()
                Button(action: {
                    popCategories = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
                .foregroundColor(.gray1000)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 15)
            
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.categoriesPlaces, spacing: 10, alignment: .leading) { category in
                Button(action: {
                    if let reader {
                        cc.selectCategoryPlaces(category: category, reader: reader)
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        popCategories = false
                    }
                }) {
                    EmoLabelView(title: category.title, isSelected: selectedCategory == category, emo: category.emoji)
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

struct PopSubCategoriesPlaces: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCategories: Bool
    @Binding var selectedCategory: Category?
    var reader: ScrollViewProxy
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text("ПОДКАТЕГОРИИ")
                    .font(bold17f)
                    .bold()
                Spacer()
                Button(action: {
                    popCategories = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
            }
                .foregroundColor(.gray1000)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 10)
                .padding(.top, 10)
                .padding(.bottom, 15)
            
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.subCategoriesPlaces, spacing: 10, alignment: .leading) { category in
                Button(action: {
                    cc.selectSubCategoryPlaces(subCat: category, reader: reader)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        popCategories = false
                    }
                }) {
                    EmoLabelView(title: category.title, isSelected: selectedCategory == category, emo: category.emoji)
                }
            }
            .padding(.bottom, 20)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
        .cornerRadius(30)
        .padding(.horizontal, 22)
    }
}
