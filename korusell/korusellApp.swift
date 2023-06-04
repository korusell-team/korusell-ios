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
    
    var body: some Scene {
        WindowGroup {
//            ContactDetailsView()
            ContactsScreen()
                .environmentObject(cc)
        }
    }
}
