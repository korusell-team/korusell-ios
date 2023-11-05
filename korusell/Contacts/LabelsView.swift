//
//  CategoryTagNavi.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/14.
//

import SwiftUI
import FirebaseFirestoreSwift
import PopupView

struct LabelsView: View {
//    @FirestoreQuery(collectionPath: "cats", predicates: [.where("p_id", isLessThanOrEqualTo: 0)], animation: .bouncy) var categories: [Category]
//    @FirestoreQuery(collectionPath: "cats", animation: .bouncy) var subCategories: [Category]
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace
    @Binding var popCategories: Bool
    
    var body: some View {
        ZStack {
            let rows = [GridItem(.flexible())]
            
            VStack(spacing: 0) {
                /// Categories list
                ZStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { reader in
                            LazyHGrid(rows: rows, alignment: .center) {
                                ForEach(cc.categories, id: \.self.id) { category in
                                    Button(action: {
                                        cc.selectCategory(category: category, reader: reader)
                                    }) {
                                        LabelView(title: category.title, isSelected: cc.selectedCategory == category)
                                    }
                                    .id(category.id)
                                }
                            }
                            .padding(.leading, 30)
                            .padding(.horizontal)
                            .frame(height: 40)
                            .popup(isPresented: $popCategories) {
                                PopCategoriesView(
                                    popCategories: $popCategories,
                                    selectedCategory: $cc.selectedCategory,
                                    reader: reader)
                            } customize: {
                                $0
                                    .type (.floater())
                                    .position(.top)
                                    .dragToDismiss(true)
                                    .closeOnTapOutside(true)
                                    .backgroundColor(.black.opacity(0.2))
                            }
                        }
                    }
                    
                    Button(action: {
                        popCategories = true
                    }) {
                        Image(systemName: "line.3.horizontal.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.gray900)
                            .frame(width: 30, height: 30)
                            .padding(4)
                            .background(Color.bg)
                            .cornerRadius(30)
                            .shadow(color: Color.gray200, radius: 2, y: 2)
                            .padding(.horizontal, 5)
                    }
                }
                
                /// Sub-categories list
                if let selectedCategory = cc.selectedCategory {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { reader in
                            LazyHGrid(rows: rows, alignment: .top) {
                                ForEach(cc.subCategories, id: \.self) { subCat in
                                    Button(action: {
                                        cc.selectSubCategory(subCat: subCat, reader: reader)
                                    }) {
                                        LabelView(title: subCat.title, isSelected: cc.selectedSubcategory == subCat)
                                    }
                                    .id(subCat.id)
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 40)
                            .background(Color.bg)
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
