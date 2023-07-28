//
//  ContentView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/07/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ContactsScreen()
                .tabItem {
                    Image(systemName: "person.crop.rectangle.stack")
                    Text("Контакты")
                }
            Text("🚧 здесь нужен дизайн...")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Поиск")
                }
            PlacesScreen()
                .tabItem {
                    Image(systemName: "map")
                    Text("Места")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
