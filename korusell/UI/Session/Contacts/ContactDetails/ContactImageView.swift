//
//  ContactImageView.swift
//  korusell
//
//  Created by Sergey Li on 11/21/23.
//

import SwiftUI
import CachedAsyncImage

struct ContactImageView: View {
    @EnvironmentObject var userManager: UserManager
    @State var page: Int = 0
    
    @Binding var user: Contact
    
    let animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                if user.image.isEmpty {
                    ZStack(alignment: .center) {
                        Color.gray50
                        VStack {
                            Text("😢")
                                .font(bold60f)
                            Text("Фотографий нет.\nУвы и ах...")
                                .foregroundColor(.gray900)
                                .multilineTextAlignment(.center)
                        }
                    }
                } else {
                    let url = user.uid == userManager.user?.uid ? URL(string: userManager.user?.image.first ?? "") : URL(string: user.image.first ?? "")
                    CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(minHeight: UIScreen.main.bounds.width)
                        case .success(let image):
                            Color.clear
                                .aspectRatio(1, contentMode: .fit)
                                .overlay(
                                    image
                                        .resizable()
                                        .scaledToFill()
                                    )
                                .clipShape(Rectangle())
                                .matchedGeometryEffect(id: "avatar", in: animation)
                            
                        case .failure:
                            ZStack(alignment: .center) {
                                Color.gray50
                                // TODO: create from this: message object with emoji, text and subtext
                                VStack {
                                    Text("🚧")
                                        .font(bold60f)
                                    Text("Что то пошло не так во время загрузки картинки...\n")
                                        .foregroundColor(.gray900)
                                        .multilineTextAlignment(.center)
                                    
                                    Text("(Возможно у Вас медленная скорость интернета)")
                                        .font(light16f)
                                        .foregroundColor(.gray700)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        @unknown default:
                            EmptyView()
                        }
                    }
                } //else
                LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                    .frame(height: 120)
            }.ignoresSafeArea()
        }
        .frame(width: UIScreen.main.bounds.width)
        .frame(minHeight: UIScreen.main.bounds.width)
        .background(Color.app_white.opacity(0.01))
        .cornerRadius(20)
    }
}

//#Preview {
//    ContactImageView()
//}
