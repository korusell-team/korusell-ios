//
//  NewPlaceCreationSheet.swift
//  korusell
//
//  Created by Sergey Li on 1/31/24.
//

import SwiftUI
import Kingfisher

struct NewPlaceCreationSheet: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var place: Place = Place(pid: "", latitude: 1, longitude: 1, categories: [])
    @State var image: UIImage? = nil
    
    @State var showImagePicker: Bool = false
    @State var imageUrl: URL? = nil
    @State var alertPresented: Bool = false
    
    @State var isPublic: Bool = false
    @State var phoneIsAvailable: Bool = false
    @State var phone: String = ""
    @State var name: String = ""
    @State var bio: String = ""
    @State var info: String? = ""
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    VStack {
                        ZStack(alignment: .top) {
                            if let image {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                            } else {
                                KFImage.url(imageUrl)
                                    .resizable()
                                    .placeholder {
                                        ZStack {
                                            VStack {
                                                Text("🫥")
                                                    .font(bold60f)
                                                Text("нет фотографии...")
                                                    .foregroundColor(.gray900)
                                                    .multilineTextAlignment(.center)
                                                    .font(light16f)
                                            }
                                        }.frame(width: Size.w(190), height: Size.w(190), alignment: .center)
                                    }
                                    .fade(duration: 1)
                                    .cancelOnDisappear(true)
                                
//                                CachedAsyncImage(url: imageUrl, urlCache: .imageCache) { phase in
//                                    switch phase {
//                                    case .empty:
//                                        ZStack {
//                                            VStack {
//                                                Text("🫥")
//                                                    .font(bold60f)
//                                                Text("нет фотографии...")
//                                                    .foregroundColor(.gray900)
//                                                    .multilineTextAlignment(.center)
//                                                    .font(light16f)
//                                            }
//                                        }.frame(width: Size.w(190), height: Size.w(190), alignment: .center)
//                                    case .success(let image):
//                                        ZStack(alignment: .top) {
//                                            image
//                                                .resizable()
//                                                .scaledToFill()
//                                        }
//                                    case .failure:
//                                        ZStack {
//                                            VStack {
//                                                Text("😖")
//                                                    .font(bold60f)
//                                                Text("Что то пошло не так...")
//                                                    .foregroundColor(.gray900)
//                                                    .multilineTextAlignment(.center)
//                                                    .font(light16f)
//                                            }
//                                        }.frame(width: Size.w(190), height: Size.w(190), alignment: .center)
//                                    @unknown default:
//                                        EmptyView()
//                                    }
//                                }
                                .ignoresSafeArea()
                            } ///else
                        }
                        
                        .frame(width: Size.w(190), height: Size.w(190), alignment: .top)
                        .background(Color.app_white.opacity(0.01))
                        .cornerRadius(30)
                        .onTapGesture {
                            showImagePicker = true
                        }
                        .sheet(isPresented: $showImagePicker) {
                            ImagePicker(image: $image)
                                .ignoresSafeArea(.all)
                        }
                        .padding(.top, Size.safeArea().top + Size.w(40))
                        
                        HStack {
                            Button(action: {
                                showImagePicker = true
                            }) {
                                Text("Выбрать фотографию")
                            }
                        }.frame(maxWidth: .infinity, alignment: .center)
                        
                    }
                    
                    VStack(spacing: 0) {
//                        CustomSection(footer: "Сделайте Ваш аккаунт публичным, чтобы пользователи могли найти Вас в списке") {
//                            Toggle(isOn: $isPublic) {
//                                MenuLabelView(title: "Публичный аккаунт", icon: "eyes", bgColor: Color.blue)
//                            }
//                        }
                        
                        CustomSection(footer: "Укажите название Места") {
                            TextField(text: $place.title.bound) {
                                Text("Название")
                            }
                            .autocorrectionDisabled()
                        }
                        
                        CustomSection(footer: "Номер телефона") {
                            TextField(text: $place.phone.bound) {
                                Text("Телефон")
                            }
                            .keyboardType(.phonePad)
                            .autocorrectionDisabled()
                        }
                        
                        CustomSection(footer: "Выберите категорию и город.\nПример:  Кафе. Ансан") {
                            VStack(spacing: 15) {
                                // TODO: implement these two for places
                                //                                CategoryEditView(user: $user, categories: cc.cats)
                                //                                Divider()
                                //                                CityEditView(user: $user, cities: cc.cities)
                            }
                            
                        }
                        
                        CustomSection(header: "Краткая информация о Месте:", footer: "Пример: Лучшее СТО в городе Инчхон!") {
                            TextField(text: $place.bio.bound) {
                                Text("Пару слов, туда - сюда")
                            }
                        }
                        
                        CustomSection(header: "О Месте:", footer: "В этой секции Вы можете выложиться по полной и описать создаваемое Место большим полотном текста.") {
                            EditInfoView(info: $place.info)
                        }
                        
                        CustomSection(header: "Соцсети и мессенджеры:", footer: "") {
                            VStack(spacing: 13) {
                                ForEach(socialType.allCases, id: \.self.id) { type in
                                    // TODO: make it for places
                                    //                                    EditSocialButton(type: type, contact: $user)
                                    Text(type.providerName)
                                    if type != .twitter {
                                        Divider()
                                    }
                                }
                            }
                        }
                        
                        // TODO: SAVE button
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
                    }
                    .background(Color.gray10.opacity(0.1))
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                    
                    Spacer().frame(height: Size.w(200))
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .background(Color.app_white)
    }
}

#Preview {
    NewPlaceCreationSheet()
}
