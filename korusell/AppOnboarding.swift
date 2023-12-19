//
//  AppOnboarding.swift
//  korusell
//
//  Created by Sergey Li on 12/18/23.
//

import SwiftUI

struct AppOnboarding: View {
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Image("onboarding-people")
                .resizable()
                .scaledToFit()
            
            Spacer()
            
            Text("ethnogram")
                .font(regular34f)
                .foregroundColor(.gray1100)
                .padding(.bottom, 10)
            
            Text("Профессионалы, предприниматели, инфлуенсеры")
                .font(regular17f)
                .foregroundColor(.black)
            
            HStack {
                ActionButton(title: "Поехали!") {
                    withAnimation {
                        userManager.isAppOnboarded = true
                        UserDefaults.standard.set(true, forKey: "appOnboarded")
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(20)
        }
        .padding(.horizontal, 22)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray50)
    }
}

#Preview {
    AppOnboarding()
}
