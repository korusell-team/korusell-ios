//
//  CategoryTagNavi.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/14.
//

import SwiftUI
//import FirebaseFirestoreSwift
import PopupView

struct LabelsView: View {
    //    @FirestoreQuery(collectionPath: "cats", predicates: [.where("p_id", isLessThanOrEqualTo: 0)], animation: .bouncy) var categories: [Category]
    //    @FirestoreQuery(collectionPath: "cats", animation: .bouncy) var subCategories: [Category]
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace
    @Binding var popCategories: Bool
    @Binding var popSubCategories: Bool
//    @Binding var searching: Bool
    
    @State var reader: ScrollViewProxy? = nil
    @State var subReader: ScrollViewProxy? = nil
    
    
    var body: some View {
        ZStack {
            let rows = [GridItem(.flexible())]
            
            VStack(spacing: 0) {
                /// Categories list
//                ZStack(alignment: .leading) {
                if !cc.searchPresented {
//                if !cc.searching {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { reader in
                            LazyHGrid(rows: rows, alignment: .center) {
                                HambButton(isOpen: $popCategories)
                                ForEach(cc.categories, id: \.self.id) { category in
                                    Button(action: {
                                        cc.selectCategory(category: category, reader: reader)
                                    }) {
                                        EmoLabelView(title: category.title, isSelected: cc.selectedCategory == category, emo: category.emoji)
                                    }
                                    .id(category.id)
                                }
                            }
                            .padding(.horizontal)
                            .frame(height: 46)
                            .onAppear {
                                self.reader = reader
                            }
//                            .popup(isPresented: $popCategories) {
//                                CategorySearchView(popCategories: $popCategories, reader: reader, subReader: subReader)
//                            } customize: {
//                                $0
//                                    .type(.toast)
//                                    .position(.bottom)
//                                    .closeOnTap(false)
//                                    .closeOnTapOutside(true)
//                                    .backgroundColor(.black.opacity(0.4))
//                            }
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
                   
                } else {
                    SearchBar(searchPresented: $cc.searchPresented)
                }
                
                
                /// Sub-categories list
//                if let selectedCategory = cc.selectedCategory {
                    ZStack(alignment: .leading) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            ScrollViewReader { reader in
                                LazyHGrid(rows: rows, alignment: .top) {
                                    if !cc.searching {
                                        HambButton(isOpen: $popSubCategories)
                                    }
                                    ForEach(cc.subCategories, id: \.self) { subCat in
                                        Button(action: {
                                            cc.selectSubCategory(subCat: subCat, reader: reader)
                                        }) {
                                            EmoLabelView(title: subCat.title, isSelected: cc.selectedSubcategory == subCat, emo: subCat.emoji)
                                        }
                                        .id(subCat.id)
                                    }
                                }
                                .padding(.horizontal)
                                .frame(height: 46)
                                .onAppear {
                                    self.subReader = reader
                                }
                                .popup(isPresented: $popSubCategories) {
                                    PopSubCategoriesView(
                                        popCategories: $popSubCategories,
                                        selectedCategory: $cc.selectedSubcategory,
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
                        .padding(.top, 7)
                        
                    }
                    .opacity(cc.searching ? 1 : (cc.selectedCategory == nil ? 0 : 1))
                    .frame(height: cc.searching ? .infinity : (cc.selectedCategory == nil ? 0 : .infinity))
                    .opacity(cc.subCategories.isEmpty ? 0 : 1)
                    .frame(height: cc.subCategories.isEmpty ? 0 : .infinity)
                    .animation(.default, value: cc.subCategories)
                    .animation(.default, value: cc.searching)
//                }
            }
        }
        .background(Color.bg)
    }
}

struct HambButton: View {
    @Binding var isOpen: Bool
    var body: some View {
        Button(action: {
            withAnimation {
                isOpen = true
            }
        }) {
            Image(systemName: "line.3.horizontal")
                .resizable()
                .scaledToFit()
                .foregroundColor(.gray700)
                .frame(width: 22, height: 22)
                .padding(7)
                .background(Color.app_white)
                .cornerRadius(30)
                .shadow(color: Color.gray200.opacity(0.2), radius: 2, x: 1, y: 1)
//                .shadow(color: Color.gray200, radius: 2, y: 2)
        }
    }
}

struct CategoryTagNavi_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactsScreen()
            .environmentObject(cc)
    }
}
