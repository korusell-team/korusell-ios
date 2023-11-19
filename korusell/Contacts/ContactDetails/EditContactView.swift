//
//  EditContactView.swift
//  korusell
//
//  Created by Sergey Li on 11/9/23.
//

import SwiftUI
import PopupView

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
                HStack {
                    Text(user.isPublic ? "🐵" : "🙈")
                        .font(bold30f)
                        .padding(.trailing, 10)
                    Text("Публичный аккаунт")
                        .font(regular17f)
                }
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 7)
            .background(Color.clear)
            .cornerRadius(5)
            
            Toggle(isOn: $user.phoneIsAvailable.bound) {
                HStack {
                    Text(user.phoneIsAvailable.bound ? "🐵" : "🙈")
                        .font(bold30f)
                        .padding(.trailing, 10)
                    Text("Номер телефона")
                        .font(regular17f)
                }
            }
            .padding(.vertical, 7)
            .padding(.horizontal, 7)
            .background(Color.clear)
            .cornerRadius(5)
            
            AccTextField(title: "Имя*", binding: $user.name.bound, textLimit: 20)
            AccTextField(title: "Фамилия*", binding: $user.surname.bound, textLimit: 20)
            
            CityEditView(user: $user, cities: cc.cities)
            CategoryEditView(user: $user, categories: cc.cats)
            
            AccTextField(title: "Заголовок*", placeholder: "Пару слов, туда - сюда", binding: $user.bio.bound, textLimit: 80)
            
            
            Spacer().frame(height: 200)
        }
        .padding(.horizontal, 16)
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
                    .font(regular17f)
                    .foregroundColor(.gray900)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(Color.app_white)
                    .cornerRadius(20)
                    .shadow(color: Color.gray200.opacity(0.2), radius: 2, x: 1, y: 1)
            }
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
                    .font(regular17f)
                    .foregroundColor(.gray900)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 15)
                    .background(Color.app_white)
                    .cornerRadius(20)
                    .shadow(color: Color.gray200.opacity(0.2), radius: 2, x: 1, y: 1)
            }
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
