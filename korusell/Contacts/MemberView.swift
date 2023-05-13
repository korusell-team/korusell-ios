//
//  MemberView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/10.
//

import SwiftUI

struct MemberView: View {
    @Binding var searchText: String
    
    @State var marked = false
    @State var liked = false
    
    let member: Member
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 5) {
                AvatarView(member: member)
                VStack(alignment: .leading) {
                    HStack {
                        Text(member.surname)
                        Text(member.name)
                    }
                    .foregroundColor(.gray1100)
                    .font(.body)
                    
                    Text("@" + member.nickname)
                        .foregroundColor(.gray500)
                }
                Spacer()
                Button(action: { self.liked.toggle() }) {
                    Image(systemName: liked ? "heart.fill" : "heart")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(liked ? .red300 : .gray600)
                        .frame(width: 20, height: 20)
                }.padding(.trailing, 10)
                Button(action: { self.marked.toggle() }) {
                    Image(systemName: marked ? "bookmark.fill" : "bookmark")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(marked ? .yellow600 : .gray600)
                        .frame(width: 20, height: 20)
                }.padding(.trailing)
            }
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack {
                        ForEach(member.tags, id: \.self) { tag in
                            TagView(tag: tag, secondText: $searchText)
                                .id(tag)
                        }
                    }.onChange(of: searchText) { text in
                        withAnimation {
                            proxy.scrollTo(searchText, anchor: .center)
                        }
                    }
                }
            }
            .padding(.bottom, 3)
            
            Color.gray900.frame(height: 0.5).padding(.horizontal)
        }
        .padding(.horizontal)
        .padding(.vertical, 3)
        
        .frame(maxWidth: .infinity)
        
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
    }
}
