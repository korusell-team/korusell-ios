//
//  EditableSocialButton.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/15.
//

import SwiftUI

struct EditableSocialButton: View {
    @EnvironmentObject var cc: ContactsController
    @State var editMode: Bool = false
    
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
    }
    
    var placeholder: String = "добавить аккаунт"
    
    let type: socialType
    var title: String? = nil
    @State var textField: String = ""
    
    var body: some View {
        HStack {
            Image(type.image)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .padding(.trailing)
            if editMode {
                TextField("", text: $textField).frame(width: 150)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .textFieldStyle(.roundedBorder)
            } else {
                Link(destination: URL(string: link)!) {
                    Text(textField == "" ? placeholder : "@" + textField)
                        .font(bodyFont)
                        .foregroundColor(textField == "" ? .gray200 : .gray1100)
                        .lineLimit(1)
                }
                .clipShape(Rectangle())
                .disabled(textField == "")
            }
            
            
            Spacer()
            
            if textField == "" {
                Button(action: edit) {
                    Image(systemName: editMode ? "checkmark.circle.fill" : "plus.circle.fill")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 25, height: 25)
                }
            } else {
                Button(action: edit) {
                    Image(systemName: editMode ? "checkmark.circle.fill" : "pencil.circle.fill")
                        .resizable()
                        .foregroundColor(editMode ? .green : .action)
                        .frame(width: 25, height: 25)
                }
                
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
            case .kakao: cc.currentUser.kakao = textField
            case .instagram: cc.currentUser.instagram = textField
            case .youtube: cc.currentUser.youtube = textField
            case .telegram: cc.currentUser.telegram = textField
            }
        }
        withAnimation {
            editMode.toggle()
        }
    }
    
    private func erase() {
        switch type {
        case .kakao: cc.currentUser.kakao = nil
        case .instagram: cc.currentUser.instagram = nil
        case .youtube: cc.currentUser.youtube = nil
        case .telegram: cc.currentUser.telegram = nil
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
        }
        return "https://\(prefix)\(title ?? "")"
    }
}

struct EditableSocialButton_Previews: PreviewProvider {
    static var previews: some View {
        EditableSocialButton(type: .kakao, title: "k0jihero")
    }
}
