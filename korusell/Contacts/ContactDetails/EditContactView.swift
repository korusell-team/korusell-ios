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
    @State var alertPresented: Bool = false
    
    @Binding var user: Contact

    var body: some View {
//        VStack(alignment: .leading, spacing: 30) {
//        Form {

//            Text("* Обязательное поле")
//                .font(regular15f)
//                .padding(.vertical, 30)
            
            Section(footer: Text("Сделайте Ваш аккаунт публичным, чтобы пользователи могли найти Вас в списке")) {
                Toggle(isOn: $user.isPublic) {
                    MenuLabelView(title: "Публичный аккаунт", icon: "eyes", bgColor: Color.blue)
                }
            }
            
            Section(footer: Text("Доступность номера телефона позволяет позвонить Вам или отправить SMS в один тап прямо из Приложения")) {
                Toggle(isOn: $user.phoneIsAvailable.bound) {
                        MenuLabelView(title: "Показать номер телефона.", subtitle: user.phone, icon: "phone.fill", bgColor: Color.green)
                }
            }
            
            Section(footer: Text("Укажите имя и фамилию")) {
                TextField(text: $user.name.bound) {
                    Text("Имя")
                }
                
                TextField(text: $user.surname.bound) {
                    Text("Фамилия")
                }
            }
            //            AccTextField(title: "Имя*", binding: $user.name.bound, textLimit: 20)
            //            AccTextField(title: "Фамилия*", binding: $user.surname.bound, textLimit: 20)
            
            Section(footer: Text("Выберите Вашу деятельность и города, которые она покрывает.\nПример:  Ведущий. Вся Корея")) {
                CategoryEditView(user: $user, categories: cc.cats)
                CityEditView(user: $user, cities: cc.cities)
            }
            
        Section(header: Text("Био:")
            .font(semiBold18f)
            .foregroundColor(.gray1100)
                ,
                footer: Text("Краткая информация о Вас.\nПример: Научу говорить по корейский без боли и страданий")) {
                TextField(text: $user.bio.bound) {
                    Text("Пару слов, туда - сюда")
                }
        }
                .textCase(nil)
            
        Section(header: Text("О себе:")
            .font(semiBold18f)
            .foregroundColor(.gray1100)
                ,
                footer: Text("В этой секции Вы можете выложиться по полной и описать Вашу деятельность большим полотном текста.")) {
            EditInfoView(info: $user.info)
        }
                .textCase(nil)
            
//            AccTextField(title: "Заголовок*", placeholder: "Пару слов, туда - сюда", binding: $user.bio.bound, textLimit: 80)
            
//            EditInfoView(info: $user.info)
            
        Section(header:
                    Text("Соцсети и мессенджеры:")
                        .font(semiBold18f)
                        .foregroundColor(.gray1100)
//                ,
//            footer:
//                    Text("Чтобы пользователи ближе узнали Вас или могли с Вами общаться в, удобном Вам, месте, Вы можете добавить аккаунты социальных сетей и мессенджеров")
        ) {
            ForEach(socialType.allCases, id: \.self.id) { type in
            EditSocialButton(type: type, contact: $user)
            }
        }
        .textCase(nil)
        
        Button(action: {
            alertPresented = true
        }) {
            Text("Выйти")
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .alert(isPresented: $alertPresented) {
            Alert(title: Text("Вы действительно хотите выйти?"),
                  primaryButton: .default(Text("Отмена"), action: { alertPresented = false }),
                  secondaryButton: .destructive(Text("Выйти"), action: userManager.signout))
        }
        
        Section(header: Text("")) {
        }
        .listRowInsets(EdgeInsets())
        .background(Color(UIColor.systemGroupedBackground))
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
        
        let placeholder = ""
        
        let textField: TextField = {
            switch type {
            case .kakao:        TextField("id", text: $contact.kakao.bound)
            case .instagram:    TextField("никнейм", text: $contact.instagram.bound)
            case .youtube:      TextField("канал", text: $contact.youtube.bound)
            case .telegram:     TextField("имя пользователя", text: $contact.telegram.bound)
            case .link:         TextField("сайт (без https://)", text: $contact.link.bound)
            case .tiktok:       TextField("id", text: $contact.tiktok.bound)
            case .linkedIn:     TextField("профайл", text: $contact.linkedIn.bound)
            case .threads:      TextField("никнейм", text: $contact.threads.bound)
            case .twitter:      TextField("никнейм", text: $contact.twitter.bound)
            case .whatsApp:     TextField("номер телефона", text: $contact.whatsApp.bound)
            }
        }()
        
    
        HStack{
            Image(type.image)
                .resizable()
                .scaledToFit()
                .frame(width: Size.w(25), height: Size.w(25))
                .padding(.trailing)
            Text(type.placeholder)
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



struct EditInfoView: View {
    @Binding var info: String?
    var textLimit: Int = 800
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
//            Text("О себе:")
//                .font(regular17f)
            ZStack {
                TextEditor(text: $info.bound)
                //                .focused($focusedField, equals: true)
                Text(info.bound).opacity(0).padding(8)
            }
            
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.white)
//            .overlay(
//                RoundedRectangle(cornerRadius: 4)
//                    .stroke(Color.gray200, lineWidth: 0.2)
//            )
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
        HStack(alignment: .center, spacing: 3) {
            TextField(placeholder, text: $binding)
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
        Button(action: {
            citiesPresented = true
        }) {
            HStack(alignment: .center) {
                Text("Город")
                    .frame(width: Size.w(90), alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                    ForEach(user.cities, id: \.self) { id in
                        if let city = cities.first(where: { $0.id == id }) {
                            Text(city.ru)
                                .font(regular17f)
                                .foregroundColor(.gray800)
                                .padding(.trailing, 6)
                                .onTapGesture {
                                    citiesPresented = true
                                }
                        }
                    }
                }
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray800)
            }
            .foregroundColor(.gray1100)
            .background(Color.white.opacity(0.1))
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
        Button(action: {
            categoriesPresented = true
        }) {
            HStack(alignment: .center) {
                Text("Категория")
                    .lineLimit(1)
                    .frame(width: Size.w(90), alignment: .leading)
                /// getting only sub categories
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                            /// matching category int with categories from db
                            let category = categories.first(where: { $0.id == cat }) ??
                            Category(id: 11110, title: "bug", p_id: 1, emoji: "👾")
                            Text(category.title)
                                .font(regular17f)
                                .foregroundColor(.gray800)
                                .padding(.trailing, 6)
                                .onTapGesture {
                                    categoriesPresented = true
                                }
//                            Text(category.emoji + "  " + category.title)
//                                .tracking(-0.5)
//                                .font(semiBold14f)
                        }
                    }
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray800)
            }
            .foregroundColor(.gray1100)
            .background(Color.white.opacity(0.1))
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

#Preview {
    EditContactView(user: .constant(dummyUser))
        .environmentObject(UserManager())
        .environmentObject(ContactsController())
}
