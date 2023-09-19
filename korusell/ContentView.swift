//
//  ContentView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/07/20.
//

import SwiftUI
import Firebase

struct ContentView: View {
    @StateObject var vc = SessionViewController()
    @StateObject var cc = ContactsController()
    @EnvironmentObject var userManager: UserManager
    
//    @AppStorage("log_Status") var status = false
    @AppStorage("appOnboarded") var appOnboarded = false
    
    var body: some View {
        ZStack {
            if !userManager.isLoading {
                if let user = userManager.user {
                    SessionView()
                        .environmentObject(vc)
                        .environmentObject(cc)
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
                .frame(width: 100, height: 100)
                .background(Color.gray300)
                .cornerRadius(25)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
