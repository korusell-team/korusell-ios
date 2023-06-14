//
//  ContactsScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

struct ContactsScreen: View {
    @EnvironmentObject var cc: ContactsController
    @Namespace var namespace
    @FocusState private var isEditing: Bool
    @State var searching = false
    
    
    let columns = [GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            VStack {
                CategoryTagNavi(searching: $searching, isEditing: $isEditing)
            ScrollView(showsIndicators: false) {
                // TODO: Implement List View ?
                    LazyVGrid(columns: columns, spacing: 0, pinnedViews: .sectionHeaders) {
//                        Section(header:
//
//                        ) {
                            MemberListView()
                                .padding(.vertical, 10)
//                        }
                    }
                }
            }
            .navigationTitle("Контакты")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                withAnimation {
                    searching.toggle()
                }
            }) {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
            }
            )
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
