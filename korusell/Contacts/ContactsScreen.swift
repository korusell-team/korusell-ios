//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI
import PopupView

struct ContactsScreen: View {
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace

    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CategoryTagNavi()
                        .padding(.top)
                    ScrollView(showsIndicators: false) {
                        // TODO: Implement List View ?
                        LazyVGrid(columns: columns, spacing: 0, pinnedViews: .sectionHeaders) {
                            ContactListView()
                                .padding(.vertical, 10)
                        }
                    }
                }
                .navigationTitle("Контакты")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading:
                                        NavigationLink(destination: {
                    Text("🚧 в разработке...")
                }) {
                    Image(systemName: "location.circle")
                        .foregroundColor(.gray900)
                }, trailing:
                                        NavigationLink(destination: {
                    Text("🚧 в разработке...")
                }) {
                    Image(systemName: "gear")
                        .foregroundColor(.gray900)
                }
                )
                .padding(.top, 0.1)
                .animation(.easeOut, value: cc.selectedCategory)
                .background(Color.gray10)
//                .popup(isPresented: $cc.openAllCategories) {
//
//                    PopCategoriesView()
//
//                } customize: {
//                    $0
//                        .type (.toast)
//                        .position(.center)
////                        .dragToDismiss(true)
////                        .closeOnTapOutside(true)
//                        .backgroundColor(.black.opacity(0.2))
                
                if cc.openAllCategories {
                    PopCategoriesView()
                }
            }
            
            
        }
//        .background(Color.gray10)
    }
}

struct PopCategoriesView: View {
    @EnvironmentObject var cc: ContactsController
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
                .onTapGesture {
                    cc.openAllCategories = false
                }
            VStack(spacing: 0) {
                TextField("Поиск", text: $cc.text, onCommit: {
                    // TODO: Test it out!
                    cc.selectedCategory = listOfCategories.filter { $0.name.lowercased() == cc.text.lowercased() }.first
                    })
                .padding()
                .background(Color.gray10)
                VStack(spacing: 0) {
                    Text("КАТЕГОРИИ")
                        .foregroundColor(.gray1000)
                        .font(headlineFont)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 22)
                        .padding(.top)
                    
                    FlexibleView(availableWidth: UIScreen.main.bounds.width - 30, data: cc.filteredCategories, spacing: 10, alignment: .leading) { category in
                        CategoryTagView(category: category)
                    }
                    if !cc.text.isEmpty {
                        ForEach(cc.filteredCategories, id: \.self) { category in
                            ForEach(category.tags.filter { $0.contains(cc.text) } , id: \.self) {
                                TagView(tag: $0)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .background(Blur(style: .systemUltraThinMaterialDark, intensity: 0.6))
            }
            
            .cornerRadius(30)
            .padding(.horizontal, 22)
        }
        .ignoresSafeArea()
        
    }
}


struct ContactsScreen_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        VStack {
            PopCategoriesView()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray100)
        
//        ContactsScreen()
            .environmentObject(cc)
    }
}
