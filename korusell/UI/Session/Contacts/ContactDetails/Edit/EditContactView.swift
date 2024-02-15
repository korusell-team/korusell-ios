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
        CustomSection(footer: "Сделайте Ваш аккаунт публичным, чтобы пользователи могли найти Вас в списке") {
            Toggle(isOn: $user.isPublic) {
                MenuLabelView(title: "Публичный аккаунт", icon: "eyes", bgColor: Color.blue)
            }
        }
        
        CustomSection(footer: "Доступность номера телефона позволяет позвонить Вам или отправить SMS в один тап прямо из Приложения") {
            Toggle(isOn: $user.phoneIsAvailable.bound) {
                MenuLabelView(title: "Показать номер телефона.", subtitle: user.phone, icon: "phone.fill", bgColor: Color.green)
            }
        }
        
        CustomSection(footer: "Укажите имя и фамилию") {
            VStack(spacing: 15) {
                TextField(text: $user.name.bound) {
                    Text("Имя")
                }
                .autocorrectionDisabled()
                
                
                Divider()
                TextField(text: $user.surname.bound) {
                    Text("Фамилия")
                }
                .autocorrectionDisabled()
            }
        }
  
        CustomSection(footer: "Выберите Вашу деятельность и города, которые она покрывает.\nПример:  Ведущий. Вся Корея") {
            VStack(spacing: 15) {
                CategoryEditView(user: $user, categories: cc.cats)
                Divider()
                CityEditView(user: $user, cities: cc.cities)
            }
            
        }
        
        CustomSection(header: "Био:", footer: "Краткая информация о Вас.\nПример: Научу говорить по корейский без боли и страданий") {
            TextField(text: $user.bio.bound) {
                Text("Пару слов, туда - сюда")
            }
        }
        
        CustomSection(header: "О себе:", footer: "В этой секции Вы можете выложиться по полной и описать Вашу деятельность большим полотном текста.") {
            EditInfoView(info: $user.info)
        }
        
        CustomSection(header: "Соцсети и мессенджеры:", footer: "Разместите Ваши соц сети и мессенджеры") {
            VStack(spacing: 13) {
                ForEach(socialType.allCases, id: \.self.id) { type in
                    EditSocialButton(type: type, contact: $user)
                    if type != .twitter {
                        Divider()
                    }
                }
            }
        }
        
        CustomSection {
            Button(action: {
                alertPresented = true
            }) {
                Text("Удалить аккаунт")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .alertPatched(isPresented: $alertPresented) {
            Alert(title: Text("Вы действительно хотите удалить Ваш аккаунт?"),
                  message: Text("Все Ваши данные будут удалены и не будут подлежать восстановлению"),
                  primaryButton: .default(Text("Отмена"), action: { alertPresented = false }),
                  secondaryButton: .destructive(Text("Удалить"), action: { userManager.deleteUser() }))
        }
        
        Spacer().frame(height: Size.w(200))
    }
}

#Preview {
    EditContactView(user: .constant(dummyUser))
        .environmentObject(UserManager())
        .environmentObject(ContactsController())
}

struct CustomSection<Content: View>: View {
    var header: String? = nil
    var footer: String? = nil
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            if let header {
                Text(header)
                    .font(regular20f)
                    .foregroundColor(.gray1100)
                    .padding(.horizontal)
            }
            
            content
                .padding(.vertical, 10)
                .padding(.horizontal)
                .background(Color.white)
            
            .clipShape(RoundedRectangle(cornerRadius: 14))
            if let footer {
                Text(footer)
                    .font(light16f)
                    .foregroundColor(.gray600)
                    .padding(.horizontal, 10)
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
    }
}

//#Preview {
//    ScrollView {
//        LazyVStack {
//            Color.red.frame(width: .infinity, height: 200)
//                .padding(.bottom, 50)
//            CustomSection(header: "header", footer: "Сделайте ваг аккаунт публичным бла бла бла") {
//                Toggle(isOn: .constant(true)) {
//                    MenuLabelView(title: "Публичный аккаунт", icon: "eyes", bgColor: Color.blue)
//                }
//            }
//        }
//    } .background(Color.app_white)
//}
