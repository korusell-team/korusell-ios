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
    
    @State var locationsPresented = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    LabelsView()
                        .padding(.top)
                    ContactListView()
                }
                .sheet(isPresented: $locationsPresented) {
                    // TODO: add filter for contacts by city
                    HalfSheet {
                        LocationsView()
                    }
                }
                .ignoresSafeArea(edges: .bottom)
                .navigationTitle("Контакты")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading:
                        Button(action: {
                            locationsPresented.toggle()
                        }) {
                            Image(systemName: "mappin.circle")
                                .foregroundColor(.gray900)
                        },
                    
                    trailing:
                        NavigationLink(destination: {
                            VStack {
                                Spacer()
                                Text("МОЙ АККАУНТ")
                                    .padding(50)
                                Text("🚧 в разработке...")
                                Spacer()
                            }
                        }) {
                            Image(systemName: "person.circle")
                                .foregroundColor(.gray900)
                        }
                )
                .padding(.top, 0.1)
                .animation(.easeOut, value: cc.selectedCategory)
                
                .background(Color.bg)
                .popup(isPresented: $cc.openAllCategories) {
                    PopCategoriesView()
                } customize: {
                    $0
                        .type (.floater())
                        .position(.top)
                        .dragToDismiss(true)
                        .closeOnTapOutside(true)
                        .backgroundColor(.black.opacity(0.2))
                }
            }
        }
    }
}

struct ContactsScreen_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
            .environmentObject(ContactsController())
    }
}
