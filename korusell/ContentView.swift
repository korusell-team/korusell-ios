//
//  ContentView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/07/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        ZStack {
            if status {
                SessionView()
            } else {
                SignInView()
            }
        }
    }
}

struct SessionView: View {
    @AppStorage("log_Status") var status = false

    var body: some View {
        TabView {
            ContactsScreen()
                .tabItem {
                    Image(systemName: "person.crop.rectangle.stack")
                    Text("Контакты")
                }
            VStack {
                Text("🚧 здесь нужен дизайн...")
                Button(action: {
                    do {
                        try Auth.auth().signOut()
                    } catch {
                        
                    }
                    
                    withAnimation { status = false }
                }) {
                    Text("Выйти")
                }
            }
            
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
