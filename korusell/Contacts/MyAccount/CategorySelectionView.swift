//
//  CategorySelectionView.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/20.
//

import SwiftUI

struct CategorySelectionView: View {
    @EnvironmentObject var cc: ContactsController
    @EnvironmentObject var userManager: UserManager
    @Binding var categorySelectionPresented: Bool
    @State var selectedCategory: Category? = nil
    @State var selectedSubcategory: String? = nil
    @State var categories: [Category] = []
    @State var subcategories: [String] = []
    
        var body: some View {
            VStack(spacing: 0) {
                Text("КАТЕГОРИИ:")
                    .foregroundColor(.gray1000)
                    .font(headlineFont)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 22)
                    .padding(.top, 22)
                
                FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: categories, spacing: 10, alignment: .leading) { category in
                        Button(action: {
                            withAnimation {
                                if selectedCategory == category {
                                    self.categories = cc.categories
                                    selectedCategory = nil
                                    self.subcategories = []
                                } else {
                                    selectedCategory = category
                                    self.categories = [category]
                                    self.subcategories = category.subCategories
                                }
                            }
                        }) {
                            LabelView(title: category.name, isSelected: selectedCategory == category)
                        }
                }
                
                if !subcategories.isEmpty {
                    Text("ПОД-КАТЕГОРИИ:")
                        .foregroundColor(.gray1000)
                        .font(headlineFont)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 22)
                        .padding(.top, 22)
                }
              
                FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: self.subcategories, spacing: 10, alignment: .leading) { sub in
                    Button(action: {
                        withAnimation {
                            selectedSubcategory = sub
                            if let selectedCategory {
                                userManager.user?.categories = [selectedCategory.name]
                            }
                            userManager.user?.subcategories = [sub]
                            categorySelectionPresented = false
                        }
                    }) {
                        LabelView(title: sub, isSelected: selectedSubcategory == sub)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
            .cornerRadius(30)
            .padding(.horizontal, 22)
            .onAppear {
                self.categories = cc.categories
            }
        }
    }

struct CategorySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CategorySelectionView(categorySelectionPresented: .constant(true))
    }
}
