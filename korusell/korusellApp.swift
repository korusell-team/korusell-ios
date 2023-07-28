//
//  korusellApp.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/07.
//

import SwiftUI

@main
struct korusellApp: App {
    @StateObject var cc = ContactsController()
    
    init() {
        
//        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().backgroundColor = UIColor(Color.gray10) 
        
        
//            //Use this if NavigationBarTitle is with Large Font
//            UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 26)!]
//            //Use this if NavigationBarTitle is with displayMode = .inline
//            UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)!]
        }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cc)
        }
    }
}
