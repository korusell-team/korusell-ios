//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

struct ContactsScreen: View {
    @FocusState private var isEditing: Bool
    @State var text = ""
    @State var selectedCategory: Category? = nil
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack {
                    if !isEditing {
                        HStack(alignment: .center) {
                            Text("Привет, \(fakeUser.name) 👋")
                            Spacer()
                            AvatarView(member: fakeUser)
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    LazyVGrid(columns: columns, spacing: 0, pinnedViews: .sectionHeaders) {
                        Section(header: SearchBar(text: $text, isEditing: $isEditing, selectedCategory: $selectedCategory)) {
                            CategoryListView(searchText: $text, selected: $selectedCategory)
                                .padding(.vertical)
                                .padding(.bottom, 10)
                            MemberListView(searchText: $text)
                        }
                    }
                }
            }
            .padding(.top, 0.1)
            .animation(.easeOut, value: isEditing)
            .animation(.easeOut, value: selectedCategory)
        }
    }
}



struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
        
    }
}
