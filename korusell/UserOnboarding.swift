//
//  UserOnboarding.swift
//  korusell
//
//  Created by Sergey Li on 12/13/23.
//

import SwiftUI

struct UserOnboarding: View {
    @EnvironmentObject var userManager: UserManager
    
    @State var image: UIImage? = nil
    @State var name: String = ""
    @State var surname: String = ""
    @State var bio: String = ""
    @State var showImagePicker: Bool = false
    @State var isLoading: Bool = false
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading) {
                Button(action: {
                    showImagePicker = true
                }, label: {
                    ZStack(alignment: .bottomTrailing) {
                        Image(uiImage: image ?? UIImage(named: "alien")!)
                            .resizable()
                            .scaledToFill()
                            .background(Color.gray100)
                            .frame(width: 70, height: 70)
                            .clipShape(Circle())
                        
                        Image(systemName: "camera.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color.app_white)
                            .background(Color.gray1000)
                            .frame(width: 20, height: 20)
                            .clipShape(Circle())
                    }
                })
                .padding(.top, 100)
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $image)
                }
                
                Text("Ваш Профиль")
                    .tracking(-0.5)
                    .font(bold24f)
                    .padding(.bottom, 1)
                
                Text("Представьтесь всему русскоязычному сообществу Кореи.")
                    .font(light14f)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray800)
                    .padding(.bottom, 5)
                
                TextField("Имя", text: $name)
                    .textContentType(.givenName)
                    .padding()
                    .background(Color.gray100)
                    .cornerRadius(15)
                    .padding(.bottom, 2)
                
                TextField("Фамилия", text: $surname)
                    .textContentType(.givenName)
                    .padding()
                    .background(Color.gray100)
                    .cornerRadius(15)
                    .padding(.bottom)
                
                Text("Ваше Био")
                    .font(regular15f)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray600)
                    .padding(.bottom, 1)
                
                TextField(text: $bio) {
                    Text("Краткая информация о Вас")
                }
                .padding()
                .background(Color.gray100)
                .cornerRadius(15)
                .padding(.bottom, 2)
                
                Text("Пример: 27yo, UI/UX дизайнер с +5 лет опыта работы")
                    .font(regular13f)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray600)
                    .padding(.horizontal, 10)
                    .padding(.bottom, 20)
                
                ActionButton(title: "Сохранить", action: save)
                
                Spacer().frame(height: 100)
            }
            .padding(.horizontal, 22)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray50)
        .overlay(
            isLoading ? LoadingElement() : nil
        )
    }
    
    private func save() {
        if let user = userManager.user {
            Task {
                self.isLoading = true
                userManager.user?.name = self.name
                userManager.user?.surname = self.surname
                userManager.user?.bio = self.bio
                if let image {
                    try await userManager.save(image: image, user: userManager.user!)
                }
                self.isLoading = false
                userManager.isUserOnboarded = true
            }
        }
    }
}

#Preview {
    UserOnboarding()
}
