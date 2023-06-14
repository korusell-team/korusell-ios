//
//  MemberView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/10.
//

import SwiftUI

struct MemberView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var cc: ContactsController
    
    @State var marked = false
    @State var liked = false
    @State var connectOpened = false
    @State var isPresentWebView = false
    @State var isPresentInfo = false
    
    let member: Member
    
    var body: some View {
    
            HStack(alignment: .center, spacing: 5) {
                AvatarView(member: member)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(member.surname)
                        Text(member.name)
                    }
                    .foregroundColor(.gray1100)
                    .font(bodyFont)
                    .padding(.leading, 8)
                    
                    let details = member.details
                    let tags = member.tags.description
                        Text(details ?? "\n")
                            .font(footnoteFont)
                            .foregroundColor(.gray400)
                            .lineLimit(2)
                            .padding(.leading, 8)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.top, 2)
                    
                }
            }
            .padding(.horizontal)
            .padding(.horizontal, 10)
            .onTapGesture {
                if anyInfoExists {
                    connectOpened.toggle()
                }
            }
            .sheet(isPresented: $connectOpened) {
                VStack {
                    AvatarView(member: member)
                    Text(member.name + member.surname)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    tagsView
                    HStack(spacing: 20) {
                        if let phone = member.phone {
                            connectButton(action: {
                                let prefix = "tel://"
                                let phoneNumberformatted = prefix + phone
                                guard let url = URL(string: phoneNumberformatted) else { return }
                                UIApplication.shared.open(url)
                            }, image: "ic-phone-call")
                            Divider()
                                .frame(height: 60)
                            connectButton(action: {
                                let sms: String = "sms:+8210\(phone)"
                                let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                                UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
                            }, image: "ic-messages")
                            Divider()
                                .frame(height: 60)
                        }
                        
                        
                        if let instagram = member.instagram {
                            connectButton(action: {
                                isPresentWebView.toggle()
                            }, image: "ic-instagram")
                            .sheet(isPresented: $isPresentWebView) {
                                WebView(url: URL(string: instagram)!)
                            }
                            Divider()
                                .frame(height: 60)
                        }
                        
                        if let link = member.link {
                            connectButton(action: {
                                openURL(URL(string: link)!)
                            }, image: "ic-www")
                            Divider()
                                .frame(height: 60)
                        }
                    }
                    
                    if let details = member.details {
                        Text("Обо мне:")
                            .font(.body)
                            .bold()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(details)
                            .font(.body)
                    }
                }
                .padding(.horizontal, 20)
            }
        
            .onAppear {
                // TODO: Change to ID
//                self.liked = member.likes.contains(where: { $0 == fakeUser.nickname })
//                self.marked = member.marks.contains(where: { $0 == fakeUser.nickname })
            }
    }
    
    @ViewBuilder
    private func connectButton(action: @escaping () -> Void, image: String) -> some View {
        let size: CGFloat = 30
        Button(action: action) {
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
    }
    
    
    var buttonsView: some View {
        VStack(alignment: .center) {
            Button(action: { self.liked.toggle() }) {
                Image(systemName: liked ? "heart.fill" : "heart")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(liked ? .red300 : .gray600)
                    .frame(width: 20, height: 20)
            }
            Button(action: { self.marked.toggle() }) {
                Image(systemName: marked ? "bookmark.fill" : "bookmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(marked ? .yellow600 : .gray600)
                    .frame(width: 20, height: 20)
            }
        }.padding(.trailing, 10)
    }
    
    var tagsView: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                ScrollViewReader { proxy in
                    HStack {
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
            // TODO: show existing of different content for scroll view
        }
        .padding(.bottom, 3)
    }
    
    private var anyInfoExists: Bool {
        return member.link != nil
        || member.details != nil
        || member.instagram != nil
        || member.phone != nil
    }
}

struct MemberView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
            MemberListView()
                .environmentObject(cc)
    }
//    static var previews: some View {
//        ScrollView(showsIndicators: false) {
//            VStack(spacing: 0) {
//                MemberView(member:
//                            Member(name: "Евгений", surname: "Хан", tags: ["тамада", "ведущий", "продюсер"], phone: "11011012"))
//                MemberView(member:
//                            Member(name: "sdf", surname: "sf", tags: ["тамада", "ведущий"]))
//                MemberView(member:
//                            Member(name: "sdf", surname: "sf", tags: ["тамада", "ведущий"]))
//                MemberView(member:
//                            Member(name: "sdf", surname: "sf", tags: ["тамада", "ведущий"]))
//            }
//        }.background(Color.bg)
//            .environmentObject(ContactsController())
//    }
}
