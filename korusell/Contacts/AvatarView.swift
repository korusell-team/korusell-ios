//
//  AvatarView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/11.
//

import SwiftUI

struct AvatarView: View {
    @State var image: UIImage?
    @State private var showSheet = false
    @State private var showAlert = false
    
    let member: Member
    var messages: Int = 0

    var body: some View {
        ZStack {
            Circle()
                .fill(Color.gray900)
                .frame(width: 46, height: 46)
            Text(String(member.name.capitalized.first ?? "?"))
                .font(.largeTitle)
                .foregroundColor(.white)
            
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .frame(width: 46, height: 46)
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            }
        }.frame(width: 54, height: 54)
         .clipShape(Circle())
         .contentShape(ContentShapeKinds.contextMenuPreview, Circle())
         .overlay(
            messagesView
         )
    }
    
    var messagesView: some View {
        ZStack {
            Circle()
                .fill(Color.red)
                .frame(width: 18, height: 18)
            Text(String(messages))
                .foregroundColor(.white)
                .font(.footnote)
        }.offset(x: 23, y: -13.5)
         .opacity(messages > 0 ? 1 : 0)
    }
}

struct AvatarView_Previews: PreviewProvider {
    static var previews: some View {
        let member = Member(name: "John", surname: "Legend")
        AvatarView(member: member, messages: 3)
            .frame(maxWidth: UIScreen.main.bounds.width, maxHeight: .infinity)
            .background(Color.yellow)
            .previewDevice("iPhone 14 Pro")
    }
}

