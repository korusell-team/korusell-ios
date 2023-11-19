//
//  SocialButton.swift
//  korusell
//
//  Created by Sergey Lee on 2023/09/04.
//

import SwiftUI
import UniformTypeIdentifiers

enum socialType: String, CaseIterable, Identifiable {
    var id: String { return self.rawValue }
    
    case kakao, instagram, youtube, telegram, link, tiktok, linkedIn, threads, twitter, whatsApp
    
    var image: String {
        switch self {
        case .kakao: return "ic-kakao"
        case .instagram: return "ic-instagram"
        case .youtube: return "ic-youtube"
        case .telegram: return "ic-telegram"
        case .link: return "ic-link"
        case .tiktok: return "ic-tiktok"
        case .linkedIn: return "ic-linkedin"
        case .threads: return "ic-threads"
        case .twitter: return "ic-twitter"
        case .whatsApp: return "ic-whatsapp"
        }
    }
    
    var placeholder: String {
        switch self {
        case .kakao: return "KakaoTalk"
        case .instagram: return "Instagram"
        case .youtube: return "Youtube"
        case .telegram: return "Telegram"
        case .link: return "Cайт"
        case .tiktok: return "TikTok"
        case .linkedIn: return "LinkedIn"
        case .threads: return "Threads"
        case .twitter: return "Twitter"
        case .whatsApp: return "WhatsApp"
        }
    }
}

struct SocialButton: View {
    let type: socialType
    var contact: Contact
    var description: String? = nil
    
    @State var alertIsPresented = false
    
    var body: some View {
        let title: String? = {
            switch type {
            case .kakao: return contact.kakao
            case .instagram: return contact.instagram
            case .youtube: return contact.youtube
            case .telegram: return contact.telegram
            case .link: return contact.link
            case .tiktok: return contact.tiktok
            case .linkedIn: return contact.linkedIn
            case .threads: return contact.threads
            case .twitter: return contact.twitter
            case .whatsApp: return contact.whatsApp
            }
        }()
        
        let link: String = {
            var prefix = ""
            switch type {
            case .kakao: prefix = ""
            case .instagram: prefix = "instagram.com/"
            case .youtube: prefix = "youtube.com/@"
            case .telegram: prefix = "t.me/"
            case .link: prefix = ""
            case .tiktok: prefix = "www.tiktok.com/@"
            case .linkedIn: prefix = "www.linkedin.com/in/"
            case .threads: prefix = "www.threads.net/@"
            case .twitter: prefix = "twitter.com/"
            case .whatsApp: prefix = "wa.me/" //phone number +8210
            }
            return "https://\(prefix)\(title ?? "")"
        }()
        
        if title?.isEmpty ?? true {
            EmptyView()
        } else {
            VStack {
                if let description {
                    Text(description)
                }
                
                if type == .kakao {
                    Button(action: {
                        print("копирование.... \(String(describing: title))")

                        UIPasteboard.general.setValue(title as Any,
                                                      forPasteboardType: UTType.plainText.identifier)
                        alertIsPresented = true
                    }) {
                        SocialButtonView(type: type, title: title)
                            .alert(isPresented: $alertIsPresented) {
                                Alert(title: Text("ID пользователя скопировано в буфер обмена"))
                            }
                    }
                } else {
                    Link(destination: URL(string: link)!) {
                        SocialButtonView(type: type, title: title)
                        .contextMenu {
                            Button(action: {
                                print("копирование.... \(String(describing: title))")
                                UIPasteboard.general.setValue(title as Any,
                                                              forPasteboardType: UTType.plainText.identifier)
                            }) {
                                Text("Скопировать")
                                Image(systemName: "doc.on.doc")
                            }
                            
                            Link(destination: URL(string: link)!) {
                                Text("Открыть")
                                Image(systemName: "link")
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct SocialButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SocialButton(type: .kakao)
//    }
//}


struct SocialButtonView: View {
    let type: socialType
    var title: String? = nil
    
    var body: some View {
        HStack(spacing: 20) {
            ZStack {
                Image(type.image)
                    .resizable()
                    .scaledToFit()
                    .opacity(0.7)
            }
            .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(type.placeholder)
                    .foregroundColor(.gray1100)
                    .font(semiBold18f)
                Group {
                    if let title, !title.isEmpty {
                        Text(type == .link ? title : "@" + title)
                    }
                }
                .font(regular15f)
                .foregroundColor(.gray600)
                .lineLimit(1)
            }
            
            Spacer()
        }
        .padding(10)
        .background(Color.white)
        .cornerRadius(30)
        .shadow(color: Color.gray200.opacity(0.2), radius: 3, x: 2, y: 2)
        .contentShape(ContentShapeKinds.contextMenuPreview, RoundedRectangle(cornerRadius: 30))
    }
}
