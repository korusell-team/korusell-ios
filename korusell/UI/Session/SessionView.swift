//
//  BottomTabView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/23.
//

import SwiftUI

struct SessionView: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        if userManager.user?.uid == "jFw6tzSYiJNxkCL3kDXT8zUXMyw2" || userManager.user?.uid == "h9TX19WYrhVg3O6z6kmVZxdXuuH2" {
            BottomTabBar(tabs: TabBarType.allCases.map({ $0.tabs })
            ) { index in
                getTabView(index: index)
            }
        } else {
            NavigationView {
                ContactsScreen()
            }
        }
    }
    
    @ViewBuilder
    func getTabView(index: Int) -> some View {
        let type = TabBarType(rawValue: index) ?? .contacts
        NavigationView {
            switch type {
            case .contacts:
                ContactsScreen()
            case .places:
                PlacesScreen()
            case .search:
                AdminView()
            }
        }
    }
}

struct BottomTabBar<Content: View>: View {
    @EnvironmentObject var vc: SessionViewController
    
    let tabs: [(String, String)]
    
    @ViewBuilder let content: (Int) -> Content
    
    var body: some View {
        ZStack {
            TabView(selection: $vc.selectedIndex) {
                ForEach(tabs.indices, id:\.self) { index in
                    content(index)
                        .tag(index)
                }
            }
            
            TabBarBottomView(tabs: tabs)
        }.ignoresSafeArea()
    }
}

struct TabBarBottomView: View {
    @EnvironmentObject var vc: SessionViewController
    @EnvironmentObject var userManager: UserManager
    
    let tabs: [(String, String)]
    let height: CGFloat = 50
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            HStack(alignment: .center) {
                HStack(alignment: .center) {
                    tabButton(index: 0)
                    tabButton(index: 1)
                    tabButton(index: 2)
                }
                .padding(.vertical, 10)
                .background(Color.gray1000.opacity(0.1))
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 35))
            }
            .frame(maxWidth: .infinity)
            .overlay(
                vc.selectedIndex == 2 ?
                AddPlaceButton(action: userManager.createPlace)
                    .transition(.move(edge: .trailing))
                : nil, alignment: .trailing
            )
            .padding(25)
            .padding(.bottom, 10)
        }
        .offset(y: vc.showBottomBar ? 0 : 100)
    }
    
    @ViewBuilder
    func tabButton(index: Int) -> some View {
        let item = tabs[index].0
        //        let title = tabs[index].1
        
        Button {
            if vc.selectedIndex == index {
                //                vc.resetPageState()
            }
            withAnimation {
                vc.selectedIndex = index
            }
        } label: {
            let isSelected = vc.selectedIndex == index
            
            ZStack {
                Circle()
                    .fill(isSelected ? Color.gray900 : .clear)
                    .frame(width: 35, height: 35)
                VStack(spacing: 5) {
                    Image(systemName: item)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                }
                .foregroundColor(isSelected ? .app_white : .gray900)
            }
            .frame(maxWidth: 60)
        }
    }
}

struct AddPlaceButton: View {
    let action: () -> Void
    @State var showCreatePlaceSheet = false
    var body: some View {
        HStack {
            Button(action: {
                showCreatePlaceSheet = true
            }) {
                ZStack {
                    Circle()
                        .fill(.clear)
                        .frame(width: 35, height: 35)
                    VStack(spacing: 5) {
                        Image(systemName: "plus")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                    }
                    .foregroundColor(.gray900)
                }
                .frame(maxWidth: 60)
                .padding(.vertical, 10)
                .background(Color.gray1000.opacity(0.1))
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 35))
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .sheet(isPresented: $showCreatePlaceSheet) {
            NewPlaceCreationSheet()
        }
    }
}

enum TabBarType: Int, CaseIterable {
    case contacts = 0
    case search
    case places
    
    var tabs: (icon: String, title: String) {
        switch self {
        case .contacts:
            return ("person.2.fill", "Контакты")
        case .search:
            //            return ("magnifyingglass", "Поиск")
            return ("person.2.badge.gearshape", "Админка")
        case .places:
            return ("mappin.and.ellipse", "Места")
        }
    }
}

struct SessionViewPreviews: PreviewProvider {
    static var previews: some View {
        SessionView()
            .environmentObject(SessionViewController())
    }
}
