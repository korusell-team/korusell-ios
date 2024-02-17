//
//  CreateContactView.swift
//  korusell
//
//  Created by Sergey Li on 1/3/24.
//

import SwiftUI

struct CreateContactView: View {
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
        
        CustomSection {
            TextField(text: $user.phone) {
                Text("Телефон")
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
        
        CustomSection(header: "Соцсети и мессенджеры:", footer: "В этой секции Вы можете выложиться по полной и описать Вашу деятельность большим полотном текста.") {
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
                  secondaryButton: .destructive(Text("Удалить"), action: {
                userManager.deleteUser(user: user)
                if let me = cc.contacts.firstIndex(where: { $0.uid == user.uid }) {
                    // MARK: refactoring
//                    cc.contacts.remove(at: me)
                }
            }))
        }
        
        Spacer().frame(height: Size.w(200))
    }
}

//#Preview {
//    CreateContactView()
//}
