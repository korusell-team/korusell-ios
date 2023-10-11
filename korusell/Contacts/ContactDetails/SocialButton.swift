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
            case .kakao: return "kakao"
            case .instagram: return "instagram"
            case .youtube: return "youtube"
            case .telegram: return "telegram"
            case .link: return "сайт"
            case .tiktok: return "tiktok"
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
                HStack {
                    Image(type.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .padding(.trailing)
                    
                    Group {
                        if let title {
                            Text(title.isEmpty ? type.placeholder : (type == .link ? title : "@" + title) )
                        } else {
                            Text(type.placeholder)
                        }
                    }
                    .font(bodyFont)
                    .foregroundColor(.gray1100)
                    .lineLimit(1)
                    
                    Spacer()
                    
                    ZStack {
                        Circle()
                            .fill(title?.isEmpty ?? true ? Color.gray200 : Color.action)
                            .frame(width: 25, height: 25)
                        Image(systemName: "chevron.right")
                            .font(bodyFont)
                            .foregroundColor(.white)
                    }
                }
                .clipShape(Rectangle())
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
