//
//  SocialButton.swift
//  korusell
//
//  Created by Sergey Lee on 2023/09/04.
//

import SwiftUI

struct SocialButton: View {
    enum socialType {
        case kakao, instagram, youtube, telegram
        
        var image: String {
            switch self {
            case .kakao: return "ic-kakao"
            case .instagram: return "ic-instagram"
            case .youtube: return "ic-youtube"
            case .telegram: return "ic-telegram"
            }
        }
        
        var placeholder: String {
            switch self {
            case .kakao: return "kakao"
            case .instagram: return "instagram"
            case .youtube: return "youtube"
            case .telegram: return "telegram"
            }
        }
    }
    
    let type: socialType
    var title: String? = nil
    
    var body: some View {
        Link(destination: URL(string: link)!) {
            HStack {
                Image(type.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing)
                
                
                Text("@" + (title ?? type.placeholder))
                    .font(bodyFont)
                    .foregroundColor(.gray1100)
                    .lineLimit(1)
                
                Spacer()
                
                ZStack {
                    Circle()
                        .fill(title == nil ? Color.gray200 : Color.action)
                        .frame(width: 25, height: 25)
                    Image(systemName: "chevron.right")
                        .font(bodyFont)
                        .foregroundColor(.white)
                }
            }
            .clipShape(Rectangle())
        }
        .disabled(title == nil)
    }
    
    private var link: String {
        print(type)
        var prefix = ""
        switch type {
        case .kakao: prefix = ""
        case .instagram: prefix = "instagram.com/"
        case .youtube: prefix = "youtube.com/@"
        case .telegram: prefix = "t.me/"
        }
        return "https://\(prefix)\(title ?? "")"
    }
}

struct SocialButton_Previews: PreviewProvider {
    static var previews: some View {
        SocialButton(type: .kakao)
    }
}
