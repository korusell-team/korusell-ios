//
//  AvatarView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/11.
//

import SwiftUI
import CachedAsyncImage

struct AvatarView: View {
    let contact: Contact

    var body: some View {
        ZStack {
            if !contact.image.isEmpty {
                CachedAsyncImage(url: URL(string: contact.image.first!), urlCache: .imageCache) { phase in
                               switch phase {
                               case .empty:
                                   ProgressView()
                               case .success(let image):
                                   image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 55, maxHeight: 55)
                                        .transition(.scale(scale: 0.1, anchor: .center))
                               case .failure:
                                   Image(systemName: "photo")
                               @unknown default:
                                   EmptyView()
                               }
                           }
//                AsyncImage(url: URL(string: contact.image.first!))
//                Image(contact.image.first!)
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 80, height: 80)
//                    .frame(width: 55, height: 55)
//                    .aspectRatio(contentMode: .fit)
//                    .clipShape(Circle())
            } else {
                Circle()
                    .fill(Color.gray900)
                    .frame(width: 55, height: 55)
                Text(String(contact.name.capitalized.first!))
                    .font(title2Font)
                    .foregroundColor(.white)
                + Text(String(contact.surname.capitalized.first!))
                    .font(title2Font)
                    .foregroundColor(.white)
            }
        }.frame(width: 55, height: 55)
         .clipShape(Circle())
         .contentShape(ContentShapeKinds.contextMenuPreview, Circle())
    }
    
//    var messagesView: some View {
//        ZStack {
//            Circle()
//                .fill(Color.red)
//                .frame(width: 18, height: 18)
//            Text(String(messages))
//                .foregroundColor(.white)
//                .font(.footnote)
//        }.offset(x: 23, y: -13.5)
//         .opacity(messages > 0 ? 1 : 0)
//    }
}

struct AvatarView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactsScreen()
            .environmentObject(cc)
    }
    
}

struct DetailsAvatarView: View {
    let contact: Contact

    var body: some View {
        let frame: CGFloat = contact.image.isEmpty ? 70 : 100
        ZStack {
            Circle()
                .fill(Color.gray900)
                .frame(width: 100, height: 100)
            Text(String(contact.name.capitalized.first!))
            + Text(String(contact.surname.capitalized.first!))
            
            // TODO: redo after DB
            if !contact.image.isEmpty {
                Image(contact.image.first!)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .frame(width: 100, height: 100)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
        }
        .font(largeTitleFont)
        .foregroundColor(.white)
        .frame(width: frame, height: frame)
        .clipShape(Circle())
        .contentShape(ContentShapeKinds.contextMenuPreview, Circle())
    }
}


extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
