//
//  ContactImageView.swift
//  korusell
//
//  Created by Sergey Li on 11/21/23.
//

import SwiftUI
import CachedAsyncImage

struct EditContactImageView: View {
//    @State var page: Int = 0
    @Binding var user: Contact
    @Binding var image: UIImage?
    @Binding var url: URL?
    
    @State var showImagePicker: Bool = false

    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                if let image {
                    ZStack(alignment: .top) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                        LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                            .frame(height: 120)
                    }
                } else {
                    CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            ZStack(alignment: .top) {
                                image
                                    .resizable()
                                    .scaledToFill()
                                LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                                    .frame(height: 120)
                            }
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .ignoresSafeArea()
                } ///else
            }
            .frame(width: UIScreen.main.bounds.width, height: Size.w(390))
            .background(Color.app_white.opacity(0.01))
            .cornerRadius(20)
            
            HStack {
                    Button(action: {
                        showImagePicker = true
                    }) {
                        Text("Изменить фото")
                    }
                    .buttonStyle(.bordered)
                    .sheet(isPresented: $showImagePicker) {
                        if let id = user.id {
                            ImagePicker(
                                image: $image)
                        }
                    }
                
            }.frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

//#Preview {
//    ContactImageView()
//}
