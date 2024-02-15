//
//  PlaceDetails.swift
//  korusell
//
//  Created by Sergey Li on 1/8/24.
//

import SwiftUI
import CachedAsyncImage

struct PlaceDetails: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userManager: UserManager
    @EnvironmentObject var vc: SessionViewController
    @EnvironmentObject var cc: ContactsController
    
    @State var editMode: Bool = false
    
    @State var offset: CGFloat = 0
    @State var image: UIImage?
    @State var isLoading: Bool = false
    
    @Namespace private var animation
    
    @State var showAlert: Bool = false
    @State var showBlock: Bool = false
    @State var showReport: Bool = false
    
    let place: PlacePoint
    
    var body: some View {
        TrackableScrollView(showIndicators: false, contentOffset: $offset) {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        if place.images.isEmpty {
                            ZStack(alignment: .center) {
                                Color.gray50
                                VStack {
                                    Text("😢")
                                        .font(bold60f)
                                    Text("Фотографий нет.\nУвы и ах...")
                                        .foregroundColor(.gray900)
                                        .multilineTextAlignment(.center)
                                }
                            }
                        } else {
                            let url = URL(string: place.images.first ?? "")
                            CachedAsyncImage(url: url, urlCache: .imageCache) { phase in
                                
                                switch phase {
                                case .empty:
                                    ProgressView()
                                        .frame(minHeight: UIScreen.main.bounds.width)
                                case .success(let image):
                                    Color.clear
                                        .aspectRatio(1, contentMode: .fit)
                                        .overlay(
                                            image
                                                .resizable()
                                                .scaledToFill()
                                        )
                                        .clipShape(Rectangle())
                                        .matchedGeometryEffect(id: "avatar", in: animation)
                                    
                                case .failure:
                                    ZStack(alignment: .center) {
                                        Color.gray50
                                        // TODO: create from this: message object with emoji, text and subtext
                                        VStack {
                                            Text("🚧")
                                                .font(bold60f)
                                            Text("Что то пошло не так во время загрузки картинки...\n")
                                                .foregroundColor(.gray900)
                                                .multilineTextAlignment(.center)
                                            
                                            Text("(Возможно у Вас медленная скорость интернета)")
                                                .font(light16f)
                                                .foregroundColor(.gray700)
                                                .multilineTextAlignment(.center)
                                        }
                                    }
                                @unknown default:
                                    EmptyView()
                                }
                            }
                        } //else
                        LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                            .frame(height: 120)
                    }.ignoresSafeArea()
                }
                .frame(width: UIScreen.main.bounds.width)
                .frame(minHeight: UIScreen.main.bounds.width)
                .background(Color.app_white.opacity(0.01))
                .cornerRadius(20)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(place.title ?? "")
                                .tracking(-0.5)
                                .font(semiBold22f)
                            
                            if let cityId = place.city {
                                if let city = cc.cities.first(where: { $0.id == cityId }) {
                                    Text(city.ru)
                                        .font(regular17f)
                                        .foregroundColor(.gray800)
                                        .padding(.trailing, 6)
                                }
                            } else {
                                Text("Город")
                                    .font(regular17f)
                                    .foregroundColor(.gray800)
                                    .padding(.trailing, 6)
                                    .opacity(0.5)
                            }
                        }
                        
                        Spacer()
                        
                        Button(action: { PhoneHelper.shared.call(place.phone ?? "") }) {
                            Image(systemName: "phone.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.green)
                                .frame(width: 50, height: 50)
                        }
                        .disabled(place.phone == nil)
                        .opacity(place.phone != nil ? 1 : 0.5)
                        
                        Button(action: { PhoneHelper.shared.sendSMS(place.phone ?? "") }) {
                            Image(systemName: "message.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.green)
                                .frame(width: 50, height: 50)
                        }
                        .disabled(place.phone == nil)
                        .opacity(place.phone != nil ? 1 : 0.5)
                    }
                    .padding(.bottom, 5)
                    
                    if place.categories.isEmpty {
                        Text("Категории")
                            .font(regular17f)
                            .foregroundColor(.gray800)
                            .padding(.trailing, 6)
                            .opacity(0.5)
                    } else {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 4) {
                                /// getting only sub categories
                                ForEach(place.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                                    /// matching category int with categories from db
                                    let category = cc.cats.first(where: { $0.id == cat }) ??
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
                    }
                    
                    Divider().padding(.vertical, 10)
                    
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text("О себе:")
                            .bold()
                            .font(semiBold18f)
                        //                        .padding(.bottom, 6)
                        
                        if let info = place.info, place.info != "" {
                            ExpandableText(text: info)
                                .lineLimit(10)
                                .collapseButton(TextSet(text: "свернуть", font: regular15f, color: .blue))
                        } else {
                            Text("Подробная информация о себе...")
                                .font(regular17f)
                                .foregroundColor(.gray800)
                                .padding(.trailing, 6)
                                .opacity(0.5)
                        }
                    }
                    .padding(6)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(socialType.allCases) { type in
                            SocialButton(type: type, place: place)
                        }
                    }
                    .padding(.vertical)
                    
                    Text("Если Вы обнаружили контент (фото, текст, ссылик), который нарушает Политику Нежелательного Контента, пожалуйста, напишите мне на guagetru.bla@gmail.com. Также Вы можете заблокировать Место или пожаловаться на него нажав на три точки в правом верхнем углу экрана")
                        .font(light14f)
                        .foregroundColor(.gray700)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.top, 100)
                    
                    Spacer(minLength: 200)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 13)
                .padding(.horizontal, 24)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .background(Color.app_white)
        .navigationBarBackButtonHidden(true)
        .applyIf(editMode) { view in
            view
                .navigationBarItems(
                    leading: Button(action: {
                        withAnimation {
                            if let user = userManager.user {
                                //                                self.user = user
                                self.image = nil
                            }
                            editMode = false
                        }
                    }) {
                        Text("Отмена")
                            .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
                    })
        }
        .applyIf(!editMode) { view in
            view
                .navigationBarItems(
                    leading:
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Image(systemName: "chevron.backward")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 10, height: 20)
                                Text("Контакты")
                            }
                            .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
                        }
                    //                        BackButton(action: { presentationMode.wrappedValue.dismiss() }, title: "Контакты")
                )
        }
        .applyIf(place.phone == userManager.user?.phone) { view in
            view.navigationBarItems(trailing:
                                        Button(action: {
                if editMode {
                    //                    save()
                } else {
                    withAnimation {
                        editMode = true
                    }
                }
            }) {
                Text(editMode ? "Сохранить" : "Изменить")
                    .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
            }
                                    // TODO: Do another condition for this
                                    //                .disabled(editMode && userManager.user == user && self.image == nil)
            )
        }
        
        // TODO: Do another condition for this
        .applyIf(place.phone != userManager.user?.phone) { view in
            view.navigationBarItems(trailing:
                                        Menu {
                Button(action: {
                    showBlock = true
                }) {
                    Label("Заблокировать", systemImage: "hand.raised")
                }.tint(.orange)
                
                Button(action: {
                    showReport = true
                }) {
                    Label("Пожаловаться", systemImage: "exclamationmark.bubble")
                }.tint(.red)
            } label: {
                Image(systemName: "ellipsis.circle")
                    .foregroundColor((offset > 0 || editMode) ? .accentColor : .white)
            }
            )
        }
    }
}

//#Preview {
//    PlaceDetails(place: dummyPlaces.first!)
//}
