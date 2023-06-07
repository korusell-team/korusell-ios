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
                        Section(header:
                                    VStack(spacing: 0) {
                            SearchBar(isEditing: $isEditing)
                            if isEditing {
                                CategoryListView()
                                    .padding(.vertical)
                                    .background(Color.gray10)
                            }
                        }) {
                            MemberListView()
                                .padding(.vertical, 10)
                            PlaceListView()
                        }
                    }
                }
            }
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
