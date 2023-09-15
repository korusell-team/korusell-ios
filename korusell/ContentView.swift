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
    
    @AppStorage("log_Status") var status = false
    @AppStorage("appOnboarded") var appOnboarded = false
    
    var body: some View {
        ZStack {
            // TODO: CHange to getting session!
            if status {
                SessionView()
                    .environmentObject(vc)
                    .environmentObject(cc)
            } else {
                if appOnboarded {
                    SignInView()
                        .transition(.move(edge: .trailing))
                } else {
                    OnboardingView()
                        .transition(.move(edge: .trailing))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
