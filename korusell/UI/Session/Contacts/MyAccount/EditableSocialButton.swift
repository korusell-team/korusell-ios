//
//  EditableSocialButton.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/15.
//

import SwiftUI

struct EditableSocialButton: View {
    @EnvironmentObject var userManager: UserManager
    @State var editMode: Bool = false
    
    enum socialType: String {
        case kakao, instagram, youtube, telegram, tiktok, link
    }
    
    var placeholder: String = "добавить аккаунт"
    
    let type: socialType
    var title: String? = nil
    @State var textField: String = ""
    
    var body: some View {
        HStack {
            Image("ic-\(type.rawValue)")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.trailing)
            if editMode {
                TextField("", text: $textField).frame(width: 150)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.URL)
                    .onSubmit {
                        edit()
                    }
            } else {
                if let url = URL(string: link) {
                    Link(destination: url) {
                        Text(textField == "" ? placeholder : (type == .link ? textField : "@" + textField))
                            .font(regular17f)
                            .foregroundColor(textField == "" ? .gray200 : .gray1100)
                            .lineLimit(1)
                    }
                    .clipShape(Rectangle())
                    .disabled(textField == "")
                }
            }
            
            Spacer()
            
            Button(action: edit) {
                Text(editMode ? "Сохранить" : (textField == "" ? "Добавить" : "Изменить"))
                    .font(regular12f)
            }
            
            if editMode {
                Button(action: erase) {
                    Image(systemName: "x.circle.fill")
                        .resizable()
                        .foregroundColor(.red)
                        .frame(width: 25, height: 25)
                }
            }
        
        }
        .onAppear {
            if let title {
                textField = title
            }
        }
    }
    
    private func edit() {
        if editMode {
            switch type {
            case .kakao: userManager.user?.kakao = textField
            case .instagram: userManager.user?.instagram = textField
            case .youtube: userManager.user?.youtube = textField
            case .telegram: userManager.user?.telegram = textField
            case .link: userManager.user?.link = textField
            case .tiktok: userManager.user?.tiktok = textField
            }
        }
        withAnimation {
            editMode.toggle()
        }
    }
    
    private func erase() {
        switch type {
        case .kakao: userManager.user?.kakao = nil
        case .instagram: userManager.user?.instagram = nil
        case .youtube: userManager.user?.youtube = nil
        case .telegram: userManager.user?.telegram = nil
        case .link: userManager.user?.link = nil
        case .tiktok: userManager.user?.tiktok = nil
        }
        withAnimation {
            textField = ""
            if editMode {
                editMode.toggle()
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

struct EditableSocialButton_Previews: PreviewProvider {
    static var previews: some View {
        EditableSocialButton(type: .kakao, title: "k0jihero")
    }
}
