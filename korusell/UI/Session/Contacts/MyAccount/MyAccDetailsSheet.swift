//
//  MyAccDetailsSheet.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/14.
//

import SwiftUI
import PopupView
import CachedAsyncImage

struct MyAccDetailsSheet: View {
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var cc: ContactsController
    @GestureState var gestureOffset: CGFloat = 0
    @FocusState var focusedField
    
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var expanded: Bool = false
    @State var editPhonePresented: Bool = false
    @State var editBioPresented: Bool = false
    @State var categoriesPresented: Bool = false
    @State var citiesPresented: Bool = false
    
    @State var name: String = ""
    @State var surname: String = ""
    @State var city: String? = nil
    @State var bio: String = ""
    
    let small: CGFloat =  UIScreen.main.bounds.height * 0.6
    
    var body: some View {
        let user = userManager.user!
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 20) {
                VStack {
                    Text("Введите Ваше имя")
                        .font(regular17f)
                    TextField("Имя", text: $name)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            userManager.user?.name = self.name
                        }
                    Text("Введите Вашу фамилию")
                        .font(regular17f)
                    TextField("Фамилия", text: $surname)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            userManager.user?.surname = self.surname
                        }
                    Text("Ваш номер телефона:")
                        .font(regular17f)
                    Text(user.phone)
                }
                .font(regular22f)
                .onAppear {
//                    self.name = user.name ?? ""
//                    self.surname = user.surname ?? ""
//                    self.city = user.cities.first
//                    self.bio = user.bio ?? "Напишите пару строк о себе..."
                }
                
                //                                        .popup(isPresented: $editPhonePresented) {
                //                                            EditPhoneView(editPhonePresented: $editPhonePresented)
                //                                        } customize: {
                //                                            $0
                //                                                .type (.floater())
                //                                                .position(.top)
                //                                                .dragToDismiss(true)
                //                                                .closeOnTapOutside(true)
                //                                                .backgroundColor(.black.opacity(0.2))
                //                                        }
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        if user.categories.isEmpty {
                            ActionButton(title: "Выберите категорию") {
                                categoriesPresented = true
                            }
                        } else {
                            Button(action: {
                                categoriesPresented = true
                            }) {
                                Text("Categories")
//                                ForEach(0..<user.categories.count, id:\.self) { index in
//                                    SmallLabelView(title: user.categories[index])
//                                }
                            }
//                            ForEach(0..<user.subcategories.count, id:\.self) { index in
//                                SmallLabelView(title: user.subcategories[index])
//                            }
                        }
                    }
                    .popup(isPresented: $categoriesPresented) {
                        CategorySelectionView(categorySelectionPresented: $categoriesPresented)
                    } customize: {
                        $0
                            .type (.floater())
                            .position(.top)
                            .dragToDismiss(true)
                            .closeOnTapOutside(true)
                            .backgroundColor(.black.opacity(0.2))
                    }
                }
                
                Divider()
                    .popup(isPresented: $citiesPresented) {
                        CitySelectionView(isOpened: $citiesPresented)
                    } customize: {
                        $0
                            .type(.toast)
                            .position(.bottom)
                            .closeOnTap(false)
                            .closeOnTapOutside(true)
                            .backgroundColor(.black.opacity(0.4))
                    }
                
                if !user.cities.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ForEach(0..<user.cities.count, id:\.self) { index in
                                if let city = cc.cities.first(where: { $0.id == index}) {
                                    Button(action: {
                                        citiesPresented = true
                                    }) {
                                        LabelView(title: city.ru, isSelected: true)
                                    }
                                }
                            }
                        }
                    }
                } else {
                    ActionButton(title: "Выберите город", action: {
                        citiesPresented = true
                    })
                }
                
                
                //TODO: set proper links prefixes and sufixes
                VStack(alignment: .leading, spacing: 10) {
                    EditableSocialButton(type: .instagram, title: user.instagram)
                    EditableSocialButton(type: .telegram, title: user.telegram)
                    EditableSocialButton(type: .kakao, title: user.kakao)
                    EditableSocialButton(type: .youtube, title: user.youtube)
                    EditableSocialButton(type: .tiktok, title: user.tiktok)
                    EditableSocialButton(type: .link, title: user.link)
                    
                }
                .padding(.bottom)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        Text("О себе:")
                            .bold()
                        Spacer()
                        Button(action: {
                            withAnimation {
                                if editBioPresented {
                                    focusedField = false
                                    userManager.user?.bio = self.bio
                                }
                                editBioPresented.toggle()
                            }
                        }) {
                            Text(editBioPresented ? "Сохранить" : "Изменить")
                                .font(regular12f)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    if editBioPresented {
                        ZStack {
                            TextEditor(text: $bio)
                                .focused($focusedField, equals: true)
                            Text(bio).opacity(0).padding(8)
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.gray200, lineWidth: 1)
                        )
                    } else {
                        Text(bio)
                    }
                }
                .font(regular17f)
                .padding(.bottom)
                
                // TODO: listOfPlaces -> change to My places logic
//                if !cc.places.isEmpty {
//                    Text("Места:")
//                        .font(regular17f)
//                        .bold()
//                    
//                    let columns = [GridItem(.flexible(maximum: 100)), GridItem(.flexible(maximum: 100)), GridItem(.flexible()), GridItem(.flexible())]
//                    
//                    LazyVGrid(columns: columns) {
//                        VStack {
//                            Button(action: {
//                                // TODO: add new Place logic
//                            }) {
//                                ZStack {
//                                    Color.gray700
//                                    Image(systemName: "plus")
//                                        .font(regular20f)
//                                        .foregroundColor(.gray10)
//                                }
//                                .frame(width: 60, height: 60)
//                                .cornerRadius(10)
//                            }
//                            Text("Добавить\nМесто")
//                                .multilineTextAlignment(.center)
//                                .font(regular12f)
//                                .lineLimit(2)
//                        }
//                        
//                        // TODO: get only my places
////                        ForEach(cc.places.filter({ $0.pid == "sdfsdfds" })) { place in
//                        ForEach(dummyPlaces, id:\.self) { place in
//                            VStack(alignment: .center) {
//                                Button(action: {
//                                    //TODO: Open Place
//                                }) {
//                                    ZStack {
//                                        if let image = place.image {
//                                            
//                                            CachedAsyncImage(url: URL(string: image), urlCache: .imageCache) { phase in
//                                                switch phase {
//                                                case .empty:
//                                                    ProgressView()
//                                                case .success(let image):
//                                                    ZStack(alignment: .top) {
//                                                        RoundedRectangle(cornerRadius: 10)
//                                                            .fill(Color.gray100)
//                                                            .frame(width: 60, height: 60)
//                                                        image
//                                                            .resizable()
//                                                            .scaledToFit()
//                                                            .frame(width: 60, height: 60)
//                                                            .cornerRadius(10)
//                                                    }
//                                                    .transition(.scale(scale: 0.1, anchor: .center))
//                                                case .failure:
//                                                    Image(systemName: "photo")
//                                                @unknown default:
//                                                    EmptyView()
//                                                }
//                                            }
//                                        } else {
//                                            RoundedRectangle(cornerRadius: 10)
//                                                .fill(Color.gray700)
//                                                .frame(width: 60, height: 60)
//                                        }
//                                    }
//                                }
//                                
//                                Text(place.title)
//                                    .multilineTextAlignment(.center)
//                                    .font(regular12f)
//                                    .lineLimit(2)
//                            }
//                            .frame(maxHeight: 120, alignment: .top)
//                        }
//                    }
//                }
                Spacer(minLength: 300)
            }
            .padding(.top, 13)
            .padding(.horizontal, 24)
        }
        .background(Color.app_white)
    }
    
    private func call() {
        guard let user = userManager.user else { return }
        let phone = user.phone
        let prefix = "tel://"
        let phoneNumberformatted = prefix + phone
        guard let url = URL(string: phoneNumberformatted) else { return }
        UIApplication.shared.open(url)
    }
    
    private func sendSMS() {
        guard let user = userManager.user else { return }
        let phone = user.phone
        let sms: String = "sms:+8210\(phone)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
}

struct MyAccDetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        MyAccDetailsSheet().environmentObject(ContactsController())
    }
}
