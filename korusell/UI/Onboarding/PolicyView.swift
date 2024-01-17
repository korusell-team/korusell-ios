//
//  PolicyView.swift
//  korusell
//
//  Created by Sergey Li on 1/14/24.
//

import SwiftUI

struct PolicyView: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var privacyAgree = false
    @State var contentAgree = false
    @State var showContentPolicy = false
    @State var showPrivcacyPolicy = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {
                showContentPolicy = true
            }, label: {
                Text("Политика нежелательного контента")
            })
            .sheet(isPresented: $showContentPolicy, content: {
                WebView(url: URL(string: "https://wide-arthropod-bad.notion.site/00bc2c43d10449a68463233a80007ee6?pvs=4")!)
            })
            
            Button(action: {
                withAnimation {
                    contentAgree.toggle()
                }
            }) {
                HStack {
                    Image(systemName: contentAgree ? "checkmark.square" : "square")
                    Text("Согласен")
                }
            }
            
            Button(action: {
                showPrivcacyPolicy = true
            }, label: {
                Text("Политика конфиденциальности")
            })
            .sheet(isPresented: $showPrivcacyPolicy, content: {
                WebView(url: URL(string: "https://wide-arthropod-bad.notion.site/4d3f3c37114243bcb9bd97ee1646bc11?pvs=4")!)
            })
        
            
            Button(action: {
                withAnimation {
                    privacyAgree.toggle()
                }
            }) {
                HStack {
                    Image(systemName: privacyAgree ? "checkmark.square" : "square")
                    Text("Согласен")
                }
            }
            
            ActionButton(title: "Готово", action: {
                withAnimation {
                    userManager.isAppOnboarded = true
                    UserDefaults.standard.set(true, forKey: "appOnboarded")
                }
            })
        }
        .padding(.horizontal, Size.w(22))
        .background(Color.gray10)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    PolicyView()
}
