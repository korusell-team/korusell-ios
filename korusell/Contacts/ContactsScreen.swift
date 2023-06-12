//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

struct ContactsScreen: View {
    @EnvironmentObject var cc: ContactsController
    @FocusState private var isEditing: Bool
    @Namespace var namespace
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
//                    if !isEditing {
//                        HStack(alignment: .center) {
//                            Text("Привет, \(fakeUser.name) 👋")
//                            Spacer()
//                            AvatarView(member: fakeUser)
//                        }
//                        .padding(.horizontal, 20)
//                    }
                    
                    LazyVGrid(columns: columns, spacing: 0, pinnedViews: .sectionHeaders) {
                        Section(header:
                                    VStack(spacing: 0) {
                            ScrollView(.horizontal, showsIndicators: false) {
                                ScrollViewReader { reader in
                                    HStack(spacing: 0) {
                                        ForEach(listOfCategories) { category in
                                            Button(action: {
                                                withAnimation {
                                                    if cc.text == category.name {
                                                        cc.selectedCategory = nil
                                                        cc.text = ""
                                                    } else {
                                                        cc.selectedCategory = category
                                                        cc.text = category.name
                                                    }
                                                }
                                            }) {
                                                VStack(spacing: 5) {
                                                    Text(category.name)
                                                        .foregroundColor(.gray600)
                                                        .font(cc.selectedCategory == category ? headlineFont : subheadFont)
//                                                    if cc.selectedCategory == category {
//                                                        Color.gray700.frame(width: .infinity, height: 1)
//                                                            .matchedGeometryEffect(id: "underline", in: namespace)
//                                                            .id(category)
//                                                    } else {
//                                                        Color.clear.frame(width: .infinity, height: 1)
//                                                    }
                                                }
                                                .padding(.vertical)
                                                .padding(.horizontal, 10)
                                                .blur(radius: cc.selectedCategory != nil && cc.selectedCategory != category ? 2 : 0)
                                            }
                                        }
                                    }
                                    .padding(.horizontal)
                                    .background(Blur(style: .prominent, intensity: 0.7))
                                    
                                    .onChange(of: cc.selectedCategory) { category in
                                        withAnimation {
                                            reader.scrollTo(category, anchor: .center)
                                        }
                                    }
                                }
                            }
                            if let category = cc.selectedCategory {
                                ScrollView(.horizontal, showsIndicators: false) {
                                    ScrollViewReader { reader in
                                        HStack(spacing: 0) {
                                            ForEach(category.tags, id: \.self) { tag in
                                                Button(action: {
                                                    withAnimation {
                                                        if cc.text == tag {
                                                            cc.text = ""
                                                        } else {
                                                            cc.text = tag
                                                        }
                                                    }
                                                }) {
                                                    VStack(spacing: 5) {
                                                        Text(tag)
                                                            .foregroundColor(.gray600)
                                                            .font(cc.text == tag ? headlineFont : subheadFont)
//                                                        if cc.text == tag {
//                                                            Color.gray700.frame(width: .infinity, height: 1)
//                                                                .matchedGeometryEffect(id: "underline-tag", in: namespace)
//                                                                .id(tag)
//                                                        } else {
//                                                            Color.clear.frame(width: .infinity, height: 1)
//                                                        }
                                                    }
                                                    .padding(.vertical)
                                                    .padding(.horizontal, 10)
                                                    .blur(radius: !cc.text.isEmpty && cc.text != tag ? 2 : 0)
                                                }
                                            }
                                        }
                                        .padding(.horizontal)
                                        .background(Blur(style: .prominent, intensity: 0.7))
                                        
                                        .onChange(of: cc.selectedCategory) { category in
                                            withAnimation {
                                                reader.scrollTo(category, anchor: .center)
                                            }
                                        }
                                    }
                                }
                            }
//                            SearchBar(isEditing: $isEditing)
//                            if isEditing {
//                                CategoryListView()
//                                    .padding(.vertical)
//                                    .background(Color.gray10)
//                            }
                        }) {
                            MemberListView()
                                .padding(.vertical, 10)
//                            PlaceListView()
                        }
                    }
                }
            }
            .navigationTitle("Контакты")
            .padding(.top, 0.1)
            .animation(.easeOut, value: isEditing)
            .animation(.easeOut, value: cc.selectedCategory)
            .background(Color.gray10)
            .onChange(of: isEditing) {
                cc.searchFocused = $0
            }
            .onChange(of: cc.text) {
                if !$0.isEmpty {
                    isEditing = true
                }
            }
            .onAppear {
                self.isEditing = cc.searchFocused
            }
        }
    }
}

struct ContactsScreen_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactsScreen()
            .environmentObject(cc)
    }
}
