//
//  OnboardingView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/22.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("appOnboarded") var appOnboarded = false
    
    @State var page: Int = 0
    
    let text = [
        "С легкостью найти\nсамых нужных людей и места!",
        "Добавляй свои любимые места на карте",
        "Делись своими профессиональными услугами",
        "и делай еще что нибудь еще...",
    ]
    
    var body: some View {
        ZStack {
            TabView(selection: $page) {
                ForEach(0..<text.count, id: \.self) {
                    Text(text[$0])
                        .multilineTextAlignment(.center)
                        .padding(20)
                        .tag($0)
                }
                .gesture(DragGesture())
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            VStack {
                HStack {
                    Button(action: {
                        appOnboarded = true
                    }) {
                        Text("Пропустить")
                            .font(footnoteFont)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.action)
                            .cornerRadius(18)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(20)

                Spacer()

                HStack(alignment: .center) {
                    HStack(alignment: .center, spacing: 4) {
                        ForEach(0..<text.count, id: \.self) { index in
                            RoundedRectangle(cornerRadius: 20)
                                .fill(page == index ? Color.action : Color.gray200)
                                .frame(width: 4 + (page == index ? 13 : 0), height: 4)
                        }
                    }
                    Spacer()
                    Button(action: {
                        withAnimation {
                            if page >= 3 {
                                appOnboarded = true
                            } else {
                                page += 1
                            }
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.action)
                                .frame(width: 34, height: 34)
                            Image(systemName: "chevron.right")
                                .foregroundColor(.white)
                                .cornerRadius(50)
                        }

                    }
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(20)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
        
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
