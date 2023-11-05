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
    var reader: ScrollViewProxy
    
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
                    cc.selectCategory(category: category, reader: reader)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        popCategories = false
                    }
                }) {
                    LabelView(title: category.title, isSelected: selectedCategory == category)
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
