//
//  EditSocialButton.swift
//  korusell
//
//  Created by Sergey Li on 12/29/23.
//

import SwiftUI

struct EditSocialButton: View {
    let type: socialType
    @Binding var contact: Contact
    
    var body: some View {
//        let title: String? = {
//            switch type {
//            case .kakao: return contact.kakao
//            case .instagram: return contact.instagram
//            case .youtube: return contact.youtube
//            case .telegram: return contact.telegram
//            case .link: return contact.link
//            case .facebook: return contact.facebook
//            case .tiktok: return contact.tiktok
//            case .linkedIn: return contact.linkedIn
//            case .threads: return contact.threads
//            case .twitter: return contact.twitter
//            case .whatsApp: return contact.whatsApp
//            }
//        }()
        
//        let placeholder = ""
        
        let textField: TextField = {
            switch type {
            case .kakao:        TextField("id", text: $contact.kakao.bound)
            case .instagram:    TextField("никнейм", text: $contact.instagram.bound)
            case .youtube:      TextField("канал", text: $contact.youtube.bound)
            case .telegram:     TextField("имя пользователя", text: $contact.telegram.bound)
            case .link:         TextField("Ссылка (без https://)", text: $contact.link.bound)
            case .facebook:     TextField("id", text: $contact.facebook.bound)
            case .tiktok:       TextField("id", text: $contact.tiktok.bound)
            case .linkedIn:     TextField("профайл", text: $contact.linkedIn.bound)
            case .threads:      TextField("никнейм", text: $contact.threads.bound)
            case .twitter:      TextField("никнейм", text: $contact.twitter.bound)
            case .whatsApp:     TextField("телефон (+821000000000)", text: $contact.whatsApp.bound)
            }
        }()
        
    
        HStack{
            Image(type.image)
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(25), height: Size.w(25))
                .padding(.trailing)
            Text(type.providerName)
                .padding(.trailing)
            
            textField
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
                .foregroundColor(.gray1100)
                .font(semiBold18f)
        }
//        .background(Color.white)
//        .contentShape(ContentShapeKinds.contextMenuPreview, RoundedRectangle(cornerRadius: 10))
        
//        HStack(spacing: 20) {
//            Image(type.image)
//                .resizable()
//                .scaledToFit()
//                .frame(width: 30, height: 30)
//
//            VStack(alignment: .leading) {
//                Text(type.placeholder)
//                    .foregroundColor(.gray600)
//                    .font(regular17f)
//
//                textField
//                    .autocorrectionDisabled()
//                    .textInputAutocapitalization(.never)
//                    .foregroundColor(.gray1100)
//                    .font(semiBold18f)
//            }
//            Spacer()
//        }
//        .padding(10)
//        .background(Color.white)
//        .cornerRadius(30)
//        .shadow(color: Color.gray200.opacity(0.2), radius: 3, x: 2, y: 2)
//        .contentShape(ContentShapeKinds.contextMenuPreview, RoundedRectangle(cornerRadius: 10))
    }
}

//#Preview {
//    EditSocialButton()
//}
