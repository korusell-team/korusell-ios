//
//  ContactDetailsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/15.
//

import SwiftUI
import YouTubePlayerKit

struct ContactDetailsView: View {
    @Environment(\.openURL) var openURL
    @EnvironmentObject var cc: ContactsController
    
    @State var isPresentWebView = false
    @State var link: String? = nil
    
    var contact: Contact
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                DetailsAvatarView(contact: contact)
                    .padding(.top)
                Text(contact.name + " " + contact.surname)
                    .font(title1Font)
                    .foregroundColor(.gray1000)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 5)
                
                if let bio = contact.bio {
                    Text(bio)
                        .font(bodyFont)
                        .foregroundColor(.gray700)
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                }
                
                tagsView
                    .padding(.horizontal, 20)
                
                HStack(spacing: 20) {
                    if let phone = contact.phone {
                        connectButton(image: "ic-phone-call") {
                            let prefix = "tel://"
                            let phoneNumberformatted = prefix + phone
                            guard let url = URL(string: phoneNumberformatted) else { return }
                            UIApplication.shared.open(url)
                        }

                        connectButton(image: "ic-messages") {
                            let sms: String = "sms:+8210\(phone)"
                            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                            UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
                        }

                    }
                    
                    
                    if let instagram = contact.instagram {
                        connectButton(image: "ic-instagram") {
                            link = instagram
                            isPresentWebView.toggle()
                        }
                    }
                    
                    if let link = contact.link {
                        connectButton(image: "ic-www") {
                            self.link = link
                            isPresentWebView.toggle()
                        }
                    }
                }
                .padding(.top)
                // TODO: ? change to item ?
                .sheet(isPresented: $isPresentWebView) {
                    if let link {
                        WebView(url: URL(string: link)!)
                    }
                }
                
                
                if let youtube = contact.youtube {
                    let player = YouTubePlayer.init(
                        source: .url(youtube),
                        configuration:
                                .init(allowsPictureInPictureMediaPlayback: true, language: "ru")
                    )
                    
                    YouTubePlayerView(player) { state in
                                switch state {
                                case .idle:
                                    ZStack {
                                        Color.black
                                        ProgressView()
                                    }
                                case .ready:
                                    EmptyView()
                                case .error(let error):
                                    Text(verbatim: "YouTube player couldn't be loaded")
                                        .foregroundColor(.white)
                                }
                            }
                    .frame(height: 220)
                    .background(Color(.systemBackground))
                    .padding(.top, 50)
                    .padding(.bottom, 200)
                }
                
               
                
                Spacer()
            }
        }
        
        // TODO: Show only after scrolling up ?
//        .navigationTitle(false ? contact.name + " " + contact.surname : "")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    @ViewBuilder
    private func connectButton(image: String, action: @escaping () -> Void) -> some View {
        let size: CGFloat = 30
        Button(action: action) {
            ZStack {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .padding(10)
            }
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray100, radius: 6, x: 4, y: 4)
            
            
                
        }
    }
    
    
//    var buttonsView: some View {
//        VStack(alignment: .center) {
//            Button(action: { self.liked.toggle() }) {
//                Image(systemName: liked ? "heart.fill" : "heart")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(liked ? .red300 : .gray600)
//                    .frame(width: 20, height: 20)
//            }
//            Button(action: { self.marked.toggle() }) {
//                Image(systemName: marked ? "bookmark.fill" : "bookmark")
//                    .resizable()
//                    .scaledToFit()
//                    .foregroundColor(marked ? .yellow600 : .gray600)
//                    .frame(width: 20, height: 20)
//            }
//        }.padding(.trailing, 10)
//    }
    
    var tagsView: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(contact.tags, id: \.self) { tag in
                        TagView(tag: tag)
                            .id(tag)
                    }
                }
            }
        }
        .padding(.vertical, 3)
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static let cc = ContactsController()
    static var previews: some View {
        NavigationView {
            ContactDetailsView(contact: listOfContacts.first(where: { $0.name == "Владимир" })!)
                .environmentObject(cc)
        }
    }
}
