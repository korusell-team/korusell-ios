//
//  ContentView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/07/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject private var vc = SessionViewController()
    @StateObject private var cc = ContactsController()
    @StateObject private var userManager = UserManager()
    
//    @AppStorage("log_Status") var status = false
//    @AppStorage("appOnboarded") var appOnboarded = false
    
    var body: some View {
        ZStack {
            if userManager.user == nil {
                SignInView()
                    .transition(.move(edge: .trailing))
            } else if !userManager.isUserOnboarded {
                UserOnboarding()
                    .transition(.move(edge: .trailing))
            } else {
                SessionView()
                    .transition(.move(edge: .trailing))
            }
            
            /// top zIndex views
            if userManager.isLoading {
                ZStack {
                    Image("logo")
                        .resizable()
                        .scaledToFit()
                    LoadingElement()
                }
                .background(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
                
            }
            if !userManager.isAppOnboarded {
                AppOnboarding()
                    .transition(.move(edge: .trailing))
            }
        
            
        }
        .onAppear(perform: userManager.handleUser)
        .environmentObject(userManager)
        .environmentObject(vc)
        .environmentObject(cc)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
