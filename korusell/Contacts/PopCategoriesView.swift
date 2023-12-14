//
//  PopCategoriesView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/23.
//

import SwiftUI
import FirebaseFirestoreSwift

struct PopCategoriesView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCategories: Bool
    @Binding var selectedCategory: Category?
    var reader: ScrollViewProxy? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            Text("КАТЕГОРИИ")
                .foregroundColor(.gray1000)
                .font(bold17f)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 22)
                .padding(.top, 22)
            
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.categories, spacing: 10, alignment: .leading) { category in
                Button(action: {
                    if let reader {
                        cc.selectCategory(category: category, reader: reader)
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

struct PopSubCategoriesView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCategories: Bool
    @Binding var selectedCategory: Category?
    var reader: ScrollViewProxy
    
    var body: some View {
        VStack(spacing: 0) {
            Text("ПОД-КАТЕГОРИИ")
                .foregroundColor(.gray1000)
                .font(bold17f)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 22)
                .padding(.top, 22)
            
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.subCategories, spacing: 10, alignment: .leading) { category in
                Button(action: {
                    cc.selectSubCategory(subCat: category, reader: reader)
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

struct EditCategoriesView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var popCategories: Bool
    @Binding var selectedCategories: [Int]
    @State var alertPresented: Bool = false
    
    var body: some View {
        ActionSheetView(fixedHeight: true, bgColor: .app_white) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Выбрано")
                    .foregroundColor(.gray1000)
                    .font(bold17f)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 22)
                    .padding(.top, 22)
                    .padding(.bottom, 10)
                
                FlexibleView(availableWidth: UIScreen.main.bounds.width, data: selectedCategories, spacing: 10, alignment: .leading) { subCat in
                    Button(action: {
                        withAnimation {
                            if let index = selectedCategories.firstIndex(where: { $0 == subCat }) {
                                    selectedCategories.remove(at: index)
                                }
                            }
                    }) {
                        let asCategory = cc.cats.first(where: { $0.id == subCat })!
                        
                        HStack {
                            Text(asCategory.emoji)
                            Text(asCategory.title)
                                .font(regular15f)
                                .padding(.trailing, 5)
                            Image(systemName: "xmark")
                        }
                        .foregroundColor(.gray900)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 10)
                        .background(Color.app_white)
                        .cornerRadius(20)
                        .shadow(color: Color.gray200.opacity(0.2), radius: 2, x: 1, y: 1)
                    }
                }
                .padding(.bottom, 20)
                
                Divider()
                
                Text("КАТЕГОРИИ")
                    .foregroundColor(.gray1000)
                    .font(bold17f)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 22)
                    .padding(.top, 22)
                    .padding(.bottom, 10)
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(cc.categories, id: \.self) { category in
                            let subCats = cc.cats.filter({ $0.p_id == category.id })
                            HStack {
                                Text(category.emoji)
                                Text(category.title)
                                    .font(semiBold18f)
                                    .foregroundColor(.gray900)
                            }
                            .padding(.vertical, 8)
                            .padding(.horizontal, 15)
                            
                            
                            FlexibleView(availableWidth: UIScreen.main.bounds.width, data: subCats, spacing: 10, alignment: .leading) { subCat in
                                Button(action: {
                                    guard selectedCategories.count < 6 else {
                                        alertPresented = true
                                        return
                                    }
                                    
                                    if !selectedCategories.contains(subCat.id) {
                                        selectedCategories.append(subCat.id)
                                    } else {
                                        if let index = selectedCategories.firstIndex(where: { $0 == subCat.id }) {
                                            selectedCategories.remove(at: index)
                                        }
                                    }
                                }) {
                                    EmoLabelView(title: subCat.title, isSelected: selectedCategories.contains(subCat.id), emo: subCat.emoji)
                                }
                            }
                            .padding(.bottom, 20)
                      
                            Divider()
                        }
                    }.frame(maxWidth: .infinity)
                        .alert(isPresented: $alertPresented) {
                            Alert(title: Text("Ограничение по количеству категорий: 6"))
                        }
                }
            }
            .padding(.horizontal, 16)
            //        .padding()
            //        .frame(maxWidth: .infinity)
            //        .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
            //        .cornerRadius(30)
            //        .padding(.horizontal, 22)
        }
    }
}

//struct PopCategoriesView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            PopCategoriesView(selectedCategory: .constant(Category(name: "asd", image: "asd", subCategories: [])))
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color.gray100)
//        .environmentObject(ContactsController())
//    }
//}
