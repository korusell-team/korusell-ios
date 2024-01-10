//
//  CreateImageView.swift
//  korusell
//
//  Created by Sergey Li on 1/3/24.
//

import SwiftUI
import CachedAsyncImage

struct CreateImageView: View {
    @EnvironmentObject var userManager: UserManager
    @Binding var user: Contact
    @Binding var image: UIImage?
    @Binding var imageUrl: URL?
    
    @Binding var showImagePicker: Bool
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    CachedAsyncImage(url: imageUrl, urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            ZStack {
                                VStack {
                                    Text("🫥")
                                        .font(bold60f)
                                    Text("нет фотографии...")
                                        .foregroundColor(.gray900)
                                        .multilineTextAlignment(.center)
                                        .font(light16f)
                                }
                            }.frame(width: Size.w(190), height: Size.w(190), alignment: .center)
                        case .success(let image):
                            ZStack(alignment: .top) {
                                image
                                    .resizable()
                                    .scaledToFill()
                            }
                        case .failure:
                            ZStack {
                                VStack {
                                    Text("😖")
                                        .font(bold60f)
                                    Text("Что то пошло не так...")
                                        .foregroundColor(.gray900)
                                        .multilineTextAlignment(.center)
                                        .font(light16f)
                                }
                            }.frame(width: Size.w(190), height: Size.w(190), alignment: .center)
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .ignoresSafeArea()
                } ///else
            }
            
            .frame(width: Size.w(190), height: Size.w(190), alignment: .top)
            .background(Color.app_white.opacity(0.01))
            .cornerRadius(300)
            .onTapGesture {
                showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(image: $image)
                    .ignoresSafeArea(.all)
            }
            .padding(.top, Size.safeArea().top + Size.w(40))
            
            HStack {
                Button(action: {
                    showImagePicker = true
                }) {
                    Text("Выбрать фотографию")
                }
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

//#Preview {
//    CreateImageView()
//}
