//
//  EditContactView.swift
//  korusell
//
//  Created by Sergey Li on 11/9/23.
//

import SwiftUI
import PopupView
import PhotosUI
import CachedAsyncImage

struct EditContactView: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var cc: ContactsController
    @FocusState var focusedField
    
    @State var editPhonePresented: Bool = false
    @State var editBioPresented: Bool = false
    @State var categoriesPresented: Bool = false
    @State var citiesPresented: Bool = false
    
    @Binding var user: Contact

    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
  

            Text("* Обязательное поле")
                .font(regular15f)
                .padding(.vertical, 30)
            
            Toggle(isOn: $user.isPublic) {
                Text("Сделать аккаунт публичным")
                    .font(regular17f)
            }
            
            Toggle(isOn: $user.phoneIsAvailable.bound) {
                Text("Показать номер телефона")
                    .font(regular17f)
            }
            
            AccTextField(title: "Имя*", binding: $user.name.bound, textLimit: 20)
            AccTextField(title: "Фамилия*", binding: $user.surname.bound, textLimit: 20)
            
            CityEditView(user: $user, cities: cc.cities)
            CategoryEditView(user: $user, categories: cc.cats)
            
            AccTextField(title: "Заголовок*", placeholder: "Пару слов, туда - сюда", binding: $user.bio.bound, textLimit: 80)
            
            EditInfoView(info: $user.info)
            
            SocialEditView(user: $user)
            
            Spacer().frame(height: 200)
        }
        .padding(.horizontal, 16)
    }
}

struct SocialEditView: View {
    @Binding var user: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(socialType.allCases) { type in
                EditSocialButton(type: type, contact: $user)
            }
        }
        .padding(.vertical)
    }
}

struct EditSocialButton: View {
    let type: socialType
    @Binding var contact: Contact
    
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
        
        let textField: TextField = {
            switch type {
            case .kakao: TextField("", text: $contact.kakao.bound)
            case .instagram: TextField("", text: $contact.instagram.bound)
            case .youtube: TextField("", text: $contact.youtube.bound)
            case .telegram: TextField("", text: $contact.telegram.bound)
            case .link: TextField("", text: $contact.link.bound)
            case .tiktok: TextField("", text: $contact.tiktok.bound)
            case .linkedIn: TextField("", text: $contact.linkedIn.bound)
            case .threads: TextField("", text: $contact.threads.bound)
            case .twitter: TextField("", text: $contact.twitter.bound)
            case .whatsApp: TextField("", text: $contact.whatsApp.bound)
            }
        }()
        
        HStack(spacing: 20) {
            Image(type.image)
                .resizable()
                .scaledToFit()
                .opacity((title == nil || title == "") ? 0.3 : 0.7)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .leading) {
                Text(type.placeholder)
                    .foregroundColor(.gray600)
                    .font(regular17f)
                
                textField
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .foregroundColor(.gray1100)
                    .font(semiBold18f)
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



struct EditInfoView: View {
    @Binding var info: String?
    var textLimit: Int = 800
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text("О себе:")
                .font(regular17f)
            ZStack {
                TextEditor(text: $info.bound)
                //                .focused($focusedField, equals: true)
                Text(info.bound).opacity(0).padding(8)
            }
            
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.gray200, lineWidth: 0.2)
            )
            .font(regular17f)
            .onChange(of: info.bound) { newValue in
                info = newValue.count > textLimit ? String(newValue.prefix(textLimit)) : newValue
            }
            
            HStack {
                Text("\(info?.count ?? 0)/\(textLimit)")
                    .font(regular15f)
                    .foregroundColor(.gray600)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 5)
        }
    }
}

struct AccTextField: View {
    let title: String
    var placeholder: String = ""
    @Binding var binding: String
    var textLimit: Int? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(title)
                .font(regular17f)
            TextField(placeholder, text: $binding)
                .textFieldStyle(.roundedBorder)
                .font(regular15f)
                .onChange(of: binding) { newValue in
                    if let textLimit {
                        binding = newValue.count > textLimit ? String(newValue.prefix(textLimit)) : newValue
                    }
                }
            
            if let textLimit {
                HStack {
                    Text("\(binding.count)/\(textLimit)")
                        .font(regular15f)
                        .foregroundColor(.gray600)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 5)
            }
        }
    }
}

struct CityEditView: View {
    @Binding var user: Contact
    @State var citiesPresented = false
    let cities: [City]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(user.cities, id: \.self) { id in
                        if let city = cities.first(where: { $0.id == id }) {
                            Text(city.ru)
                                .font(regular17f)
                                .foregroundColor(.gray800)
                                .padding(.trailing, 6)
                        }
                    }
                }
            }
            Button(action: {
                citiesPresented = true
            }) {
                Text("Выбрать город")
            }
            .buttonStyle(.bordered)
            
            .popup(isPresented: $citiesPresented) {
                PopCitiesView(user: $user, popCities: $citiesPresented)
            } customize: {
                $0
                    .type (.floater())
                    .position(.top)
                    .dragToDismiss(true)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.2))
            }
        }
    }
}

struct CategoryEditView: View {
    @Binding var user: Contact
    @State var categoriesPresented = false
    let categories: [Category]
    
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    /// getting only sub categories
                    ForEach(user.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                        /// matching category int with categories from db
                        let category = categories.first(where: { $0.id == cat }) ??
                        Category(id: 11110, title: "bug", p_id: 1, emoji: "👾")
                        Text(category.emoji + "  " + category.title)
                            .tracking(-0.5)
                            .font(semiBold14f)
                            .padding(.vertical, 7)
                            .padding(.horizontal, 10)
                            .overlay(
                                Capsule(style: .continuous)
                                    .stroke(Color.gray200, lineWidth: 1)
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.vertical, 4)
                    }
                }
            }
            .foregroundColor(.gray1000)
            
            Button(action: {
                categoriesPresented = true
            }) {
                Text("Выбрать категорию")
            }
            .buttonStyle(.bordered)
            
            .popup(isPresented: $categoriesPresented) {
                EditCategoriesView(popCategories: $categoriesPresented, selectedCategories: $user.categories)
            } customize: {
                $0
                    .type(.toast)
                    .position(.bottom)
                    .closeOnTap(false)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.4))
            }
        }
    }
}

//#Preview {
//    EditContactView(contact: du)
//}
