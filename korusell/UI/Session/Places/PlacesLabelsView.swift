//
//  PlacesLabelsView.swift
//  korusell
//
//  Created by Sergey Li on 1/24/24.
//

import SwiftUI
import FirebaseFirestoreSwift
import PopupView

struct PlacesLabelsView: View {
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace
    @Binding var popCategories: Bool
    @Binding var popSubCategories: Bool
    @State var reader: ScrollViewProxy? = nil
    @State var subReader: ScrollViewProxy? = nil
    
    var body: some View {
        ZStack {
            let rows = [GridItem(.flexible())]
            
            VStack(spacing: 0) {
                /// Categories list
                //                ZStack(alignment: .leading) {
                ScrollView(.horizontal, showsIndicators: false) {
                    ScrollViewReader { reader in
                        LazyHGrid(rows: rows, alignment: .center) {
                            HambButton(isOpen: $popCategories)
                            ForEach(cc.categoriesPlaces, id: \.self.id) { category in
                                Button(action: {
                                    cc.selectCategoryPlaces(category: category, reader: reader)
                                }) {
                                    EmoLabelView(title: category.title, isSelected: cc.selectedCategoryPlaces == category, emo: category.emoji)
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
                            PopCategoriesPlaces(
                                popCategories: $popCategories,
                                selectedCategory: $cc.selectedCategoryPlaces,
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
                
                //                }
                
                
                /// Sub-categories list
                //                if let selectedCategory = cc.selectedCategory {
                ZStack(alignment: .leading) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        ScrollViewReader { reader in
                            LazyHGrid(rows: rows, alignment: .top) {
                                HambButton(isOpen: $popSubCategories)
                                
                                ForEach(cc.subCategoriesPlaces, id: \.self) { subCat in
                                    Button(action: {
                                        cc.selectSubCategoryPlaces(subCat: subCat, reader: reader)
                                    }) {
                                        EmoLabelView(title: subCat.title, isSelected: cc.selectedSubcategoryPlaces == subCat, emo: subCat.emoji)
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
                                PopSubCategoriesPlaces(
                                    popCategories: $popSubCategories,
                                    selectedCategory: $cc.selectedSubcategoryPlaces,
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
                .opacity(cc.selectedCategoryPlaces == nil ? 0 : 1)
                .frame(height: cc.selectedCategoryPlaces == nil ? 0 : .infinity)
                //                }
            }
        }
    }
}

#Preview {
    PlacesLabelsView(popCategories: .constant(true), popSubCategories: .constant(true))
}
