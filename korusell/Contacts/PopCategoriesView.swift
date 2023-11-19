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
//    @State var selectedSubCategories: [Int] = []
    
    var body: some View {
        ActionSheetView(fixedHeight: true, bgColor: .app_white) {
            VStack(alignment: .leading, spacing: 0) {
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
                                    if !selectedCategories.contains(subCat.id) {
                                        selectedCategories.append(subCat.id)
                                        selectedCategories.append(category.id)
                                    } else {
                                        if let index = selectedCategories.firstIndex(where: { $0 == subCat.id }) {
                                            selectedCategories.remove(at: index)
                                        }
//                                        if let index = selectedCategories.firstIndex(where: { $0 == category.id }) {
//                                            selectedCategories.remove(at: index)
//                                        }
                                    }
                                }) {
                                    EmoLabelView(title: subCat.title, isSelected: selectedCategories.contains(subCat.id), emo: subCat.emoji)
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    }.frame(maxWidth: .infinity)
                }
            }
            //        .padding()
            //        .frame(maxWidth: .infinity)
            //        .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
            //        .cornerRadius(30)
            //        .padding(.horizontal, 22)
        }
    }
}

struct PopCitiesView: View {
    @EnvironmentObject var cc: ContactsController
    @Binding var user: Contact
    @Binding var popCities: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            Text("ГОРОДА")
                .foregroundColor(.gray1000)
                .font(bold17f)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 22)
                .padding(.top, 22)
        
            FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.cities.sorted(by: { $0.id < $1.id }), spacing: 10, alignment: .leading) { city in
                    Button(action: {
                        if city.id == 0 {
                            if !user.cities.contains(city.id) {
                                user.cities.removeAll()
//                                user.cities.append(contentsOf: cc.cities.compactMap({ $0.id }))
                                user.cities.append(city.id)
                            } else {
                                user.cities.removeAll()
                            }
                        } else {
                            if !user.cities.contains(city.id) {
                                user.cities.append(city.id)
                            } else {
                                if let index = user.cities.firstIndex(where: { $0 == city.id }) {
                                    user.cities.remove(at: index)
                                }
                            }
                            
                            if let _ = user.cities.firstIndex(where: { $0 == 0 }) {
                                // MARK: remove all on unselecting any city
                                user.cities.removeAll()
                                // MARK: add all except 0 and unselected city
                                user.cities.append(contentsOf: cc.cities.filter({ $0.id != 0 && $0.id != city.id }).compactMap({ $0.id }))
                            }
                            // MARK: if user.cities has all cities remove all cities and add only 0
                            if user.cities.count + 1 >= cc.cities.count {
                                user.cities.removeAll()
                                user.cities.append(0)
                            }
                        }
                    }) {
                        // MARK: 0 - all cities
                        LabelView(title: city.ru, isSelected: user.cities.contains(city.id) || user.cities.contains(0))
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
