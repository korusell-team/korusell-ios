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
    @AppStorage("appOnboarded") var appOnboarded = false
    
    var body: some View {
        ZStack {
            if !userManager.isLoading {
                if let user = userManager.user {
                    SessionView()
                       
                } else {
                    if appOnboarded {
                        SignInView()
                    } else {
                        OnboardingView()
                            .transition(.move(edge: .trailing))
                    }
                }
            } else {
                // TODO: Change it to Launch Screen
                VStack {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                }
                .frame(width: 50, height: 50)
                .background(Blur(style: .systemUltraThinMaterialDark))
                .cornerRadius(10)
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
