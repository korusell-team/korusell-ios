//
//  MemberView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/10.
//

import SwiftUI

struct MemberView: View {
    @EnvironmentObject var cc: ContactsController
    
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
                        //TODO: Test it out!
                        EmptyView().id("")
                        ForEach(member.tags, id: \.self) { tag in
                            TagView(tag: tag)
                                .id(tag)
                        }
                    }.onChange(of: cc.text) { text in
                        withAnimation {
                            proxy.scrollTo(cc.text, anchor: .center)
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
        .onAppear {
            self.liked = member.likes.contains(where: { $0 == fakeUser.nickname })
            self.marked = member.marks.contains(where: { $0 == fakeUser.nickname })
        }
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
    }
}
