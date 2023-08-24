////
////  CategoryView.swift
////  korusell
////
////  Created by Sergey Lee on 2023/05/13.
////
//
//import SwiftUI
//
//struct CategoryView: View {
//    @EnvironmentObject var cc: ContactsController
//    var category: Category
//    
//    var body: some View {
//        VStack(spacing: 10) {
//            Button(action: {
//                withAnimation {
//                    cc.selectedCategory = category
//                    cc.text = category.name
//                }
//            }) {
//                Image(category.image)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 25, height: 25)
//                    .padding()
//                    .background(Color.gray100.opacity(0.5))
//                    .cornerRadius(10)
////                    .shadow(color: .gray50, radius: 1, x: 1, y: 1)
//            }
//            Text(category.name)
//                .font(.footnote)
//                .lineSpacing(-20)
//                .foregroundColor(.gray900)
//                .multilineTextAlignment(.center)
//                .padding(.horizontal, 10)
//        }.frame(width: 80, height: 110, alignment: .top)
//    }
//}
//
//struct CategoryView_Previews: PreviewProvider {
//    static let cc = ContactsController()
//    static var previews: some View {
//        VStack {
//            CategoryListView()
//        }.background(Color.gray10)
//        
//            .environmentObject(cc)
////        CategoryView(category: Category(name: "IT, Дизайн", image: "design"))
//    }
//}
