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
    @EnvironmentObject var userManager: UserManager
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
                            MyAccountView()
                        }) {
                            Image(systemName: "person.circle")
                                .foregroundColor(.gray900)
                        }.disabled(userManager.user == nil)
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
                .popup(isPresented: $locationsPresented) {
                    CitiesView()
                } customize: {
                    $0
                        .type(.toast)
                        .position(.bottom)
                        .closeOnTap(false)
                        .closeOnTapOutside(true)
                        .backgroundColor(.black.opacity(0.4))
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
