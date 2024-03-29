//
//  ContactImageView.swift
//  korusell
//
//  Created by Sergey Li on 11/21/23.
//

import SwiftUI
import CachedAsyncImage

struct EditContactImageView: View {
    @EnvironmentObject var userManager: UserManager
    //    @State var page: Int = 0
    @Binding var user: Contact
    @Binding var image: UIImage?
    
    @Binding var showImagePicker: Bool
    let animation: Namespace.ID
    
    var body: some View {
        VStack {
            ZStack(alignment: .top) {
                if let image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                } else {
                    CachedAsyncImage(url: userManager.userImageUrl, urlCache: .imageCache) { phase in
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
                                    .matchedGeometryEffect(id: "avatar", in: animation)
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
            
            .frame(width: Size.w(190), height: Size.w(190), alignment: .center)
            .background(Color.app_white.opacity(0.01))
            .cornerRadius(300)
            
            //            .overlay(
            //                Image(systemName: "pencil.circle")
            //                    .resizable()
            //                    .scaledToFit()
            //                    .foregroundColor(.gray1000)
            //                    .frame(width: Size.w(30), height: Size.w(30))
            //                    .padding(4)
            //                    .background(Color.app_white)
            //                    .clipShape(Circle())
            //                    .shadow(radius: 1)
            //                    .padding(Size.w(10)), alignment: .bottomTrailing
            //            )
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
//    return EditContactImageView(user: .constant(dummyUser), image: .constant(UIImage(named: "sergey-lee")), url: .constant(URL(string: "")), animation: animation)
//}
