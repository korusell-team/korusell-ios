//
//  CategorySearchView.swift
//  korusell
//
//  Created by Sergey Li on 12/26/23.
//

import SwiftUI

struct CategorySearchView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCategories: Bool
    @State var searchField: String = ""
    var reader: ScrollViewProxy
    var subReader: ScrollViewProxy?
    
    var body: some View {
        ActionSheetView(fixedHeight: true, bgColor: .app_white) {
            VStack {
                SearchBar(searchField: $searchField)
                VStack {
                    ScrollView(.vertical, showsIndicators: false) {
                        FlexibleView(availableWidth: UIScreen.main.bounds.width, data: cc.searchCategories, spacing: 10, alignment: .leading) { cat in
                            Button(action: {
                                let p_cat = cc.cats.first(where: { $0.id == cat.p_id })!
                                cc.selectCategory(category: p_cat, reader: reader)
                                cc.selectSubCategory(subCat: cat, reader: subReader!)
                                self.popCategories = false
                            }) {
                                HStack {
                                    Text(cat.emoji) 
                                    Text(cat.title)
                                        .font(regular15f)
                                        .padding(.trailing, 5)
                                }
                                .foregroundColor(.gray900)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 10)
                                .background(Color.app_white)
                                .cornerRadius(20)
                                .shadow(color: Color.gray200.opacity(0.2), radius: 2, x: 1, y: 1)
                            }
                        }
                    }
                }
            }
        }
        .onChange(of: searchField) { newField in
            if newField.isEmpty {
                cc.searchCategories = cc.searchCategoriesFull
            } else {
                cc.searchCategories = cc.searchCategoriesFull.filter { $0.title.lowercased().contains(newField) }
            }
        }
    }
}

//#Preview {
//    CategorySearchView().environmentObject(ContactsController())
//}
