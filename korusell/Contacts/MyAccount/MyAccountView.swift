//
//  MyAccountView.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/13.
//

import SwiftUI
import CachedAsyncImage

struct MyAccountView: View {
    @EnvironmentObject var cc: ContactsController
    @EnvironmentObject var userManager: UserManager
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var page: Int = 0
    
    var body: some View {
        let user = userManager.user!
        ZStack {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    if user.image.isEmpty {
                        ZStack(alignment: .bottom) {
                            Color.gray50
                            Image("alien")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 1.5)
                        }
                    } else {
                        TabView(selection: $page) {
                            ForEach(0..<user.image.count, id: \.self) { index in
                                CachedAsyncImage(url: URL(string: user.image[index]), urlCache: .imageCache) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        ZStack(alignment: .top) {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                            LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                                                .frame(height: 150)
                                        }
                                        .transition(.scale(scale: 0.1, anchor: .center))
                                    case .failure:
                                        Image(systemName: "photo")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .tag(index)
                                .ignoresSafeArea()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
                    
                    if user.image.count > 1 {
                        HStack(alignment: .center, spacing: 4) {
                            ForEach(0..<user.image.count, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(page == index ? 1 : 0.5))
                                    .frame(width: 4 + (page == index ? 13 : 0), height: 4)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 55)
                    }
                }
                .background(Color.white.opacity(0.01))
                .frame(maxHeight: UIScreen.main.bounds.height * 0.45, alignment: .center)
                //                .offset(y: -30)
                Spacer()
            }
            
            MyAccDetailsSheet()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .animation(.default, value: page)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { presentationMode.wrappedValue.dismiss() }, title: "Контакты"))
    }
}

struct MyAccountView_Previews: PreviewProvider {
    static var previews: some View {
        MyAccountView().environmentObject(ContactsController())
    }
}
