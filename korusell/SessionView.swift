//
//  BottomTabView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/23.
//

import SwiftUI

struct SessionView: View {
    
    var body: some View {
        BottomTabBar(tabs: TabBarType.allCases.map({ $0.tabs })
        ) { index in
            getTabView(index: index)
        }
    }
    
    @ViewBuilder
    func getTabView(index: Int) -> some View {
        let type = TabBarType(rawValue: index) ?? .main
        
        switch type {
        case .main:
            ContactsScreen()
        case .report:
            GlobalSearchView()
        case .alarm:
            PlacesScreen()
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
    
    let tabs: [(String, String)]
    let height: CGFloat = 50
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            HStack(alignment: .center) {
                tabButton(index: 0)
                tabButton(index: 1)
                tabButton(index: 2)
            }
            .padding(.horizontal, 45)
            .padding(.vertical, 10)
            .background(Blur(style: .systemUltraThinMaterialDark))
            .frame(maxWidth: .infinity)
            .cornerRadius(20)
            .padding(25)
            .padding(.bottom, 10)
        }
        .offset(y: vc.showBottomBar ? 0 : 100)
    }
    
    @ViewBuilder
    func tabButton(index: Int) -> some View {
        let item = tabs[index].0
        let title = tabs[index].1
        
        Button {
            if vc.selectedIndex == index {
//                vc.resetPageState()
            }
            vc.selectedIndex = index
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
                .foregroundColor(isSelected ? .white : .gray900)
            }
            .frame(maxWidth: .infinity)
        }
    }
}

enum TabBarType: Int, CaseIterable {
    case main = 0
    case report
    case alarm

    var tabs: (icon: String, title: String) {
        switch self {
        case .main:
            return ("person.2.fill", "Контакты")
        case .report:
            return ("magnifyingglass", "Поиск")
        case .alarm:
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
