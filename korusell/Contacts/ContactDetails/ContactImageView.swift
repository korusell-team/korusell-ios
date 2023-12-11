//
//  ContactImageView.swift
//  korusell
//
//  Created by Sergey Li on 11/21/23.
//

import SwiftUI
import CachedAsyncImage

struct ContactImageView: View {
    @State var page: Int = 0
    
    let contact: Contact
    let animation: Namespace.ID
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ZStack(alignment: .top) {
                if contact.image.isEmpty {
                    ZStack(alignment: .bottom) {
                        Color.gray50
                        Image("alien")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width / 1.5)
                    }
                } else {
                    //                TabView(selection: $page) {
                    //                    ForEach(0..<contact.image.count, id: \.self) { index in
                    //                        CachedAsyncImage(url: URL(string: contact.image[index]), urlCache: .imageCache) { phase in
                    CachedAsyncImage(url: URL(string: contact.image.first ?? ""), urlCache: .imageCache) { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
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
                            Image(systemName: "photo")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    //                        .tag(index)
                    
                    //                    }
                    //                }
                    //                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    //                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
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
