//
//  SocialButton.swift
//  korusell
//
//  Created by Sergey Lee on 2023/09/04.
//

import SwiftUI

struct SocialButton: View {
    enum socialType {
        case kakao, instagram, youtube, telegram, link, tiktok
        
        var image: String {
            switch self {
            case .kakao: return "ic-kakao"
            case .instagram: return "ic-instagram"
            case .youtube: return "ic-youtube"
            case .telegram: return "ic-telegram"
            case .link: return "ic-link"
            case .tiktok: return "ic-tiktok"
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
            }
        }
    }
    
    let type: socialType
    var title: String? = nil
    
    var body: some View {
        if title?.isEmpty ?? true {
            EmptyView()
        } else {
            Link(destination: URL(string: link)!) {
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
            }
        }
    }
    
    private var link: String {
        var prefix = ""
        switch type {
        case .kakao: prefix = ""
        case .instagram: prefix = "instagram.com/"
        case .youtube: prefix = "youtube.com/@"
        case .telegram: prefix = "t.me/"
        case .link: prefix = ""
        case .tiktok: prefix = "www.tiktok.com/@"
        }
        return "https://\(prefix)\(title ?? "")"
    }
}

struct SocialButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialButton(type: .kakao)
    }
}
