//
//  PlaceView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/04.
//

import SwiftUI

struct PlaceView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var cc: ContactsController
    
    @State var marked = false
    @State var liked = false
    @State var connectOpened = false
    @State var isPresentWebView = false
    @State var isPresentInfo = false
    
    let place: Place
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 5) {
//                AvatarView(member: place)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text(place.name)
                    }
                    .foregroundColor(.gray1100)
                    .font(.body)
                    .padding(.leading, 8)
                    tagsView
                }
                
                Spacer()
                //                    buttonsView
                
                
            }
            //                .frame(height: 80)
            .padding(.horizontal)
            .padding(.top, 15)
            //            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.gray100, radius: 3, y: 2)
            .zIndex(2)
            .onTapGesture {
                withAnimation(.interpolatingSpring(stiffness: 100, damping: 10)) {
                    if anyInfoExists {
                        connectOpened.toggle()
                    }
                }
            }
            
            VStack {
                HStack(spacing: 20) {
                    if let phone = place.phone {
                        connectButton(action: {
                            let prefix = "tel://"
                            let phoneNumberformatted = prefix + phone
                            guard let url = URL(string: phoneNumberformatted) else { return }
                            UIApplication.shared.open(url)
                        }, image: "ic-phone-call")
                        Divider()
                        connectButton(action: {
                            let sms: String = "sms:+8210\(phone)"
                            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                            UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
                        }, image: "ic-messages")
                        Divider()
                    }
                    
                    
                    if let instagram = place.instagram {
                        connectButton(action: {
                            isPresentWebView.toggle()
                            //                        openURL(URL(string: "https://www.instagram.com")!)
                        }, image: "ic-instagram")
                        .sheet(isPresented: $isPresentWebView) {
                            WebView(url: URL(string: instagram)!)
                        }
                        Divider()
                    }
                    
                    if let link = place.link {
                        connectButton(action: {
                            openURL(URL(string: link)!)
                        }, image: "ic-www")
                        Divider()
                    }

                    if let details = place.details {
                        connectButton(action: {
                            isPresentInfo.toggle()
                        }, image: "ic-details")
                        .sheet(isPresented: $isPresentInfo) {
                            VStack {
                                Text("Place details. Add me!")
                                    .padding(.bottom)
                                Text(details)
                            }
                        }
                    }
                }
                .font(.largeTitle)
                .foregroundColor(.gray600)
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
            }
            .frame(height: connectOpened ? 70 : 0, alignment: .bottom)
            .opacity(connectOpened ? 1 : 0)
            .background(Color.white)
            .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
        }.padding(.horizontal, 10)
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
                        ForEach(place.tags, id: \.self) { tag in
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
        return place.link != nil
        || place.details != nil
        || place.instagram != nil
        || place.phone != nil
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                PlaceView(place: Place(name: "Кафе Виктория", tags: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"]))
                PlaceView(place: Place(name: "Habsida", tags: ["IT", "программирование", "обучение"]))
                PlaceView(place: Place(name: "СТО", tags: ["транспорт", "ремонт"]))
            }
        }.background(Color.bg)
            .environmentObject(ContactsController())
    }
}

