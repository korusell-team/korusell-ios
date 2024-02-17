//
//  ContactView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/10.
//

import SwiftUI

struct ContactView: View {
    @EnvironmentObject var cc: ContactsController
    @EnvironmentObject var userManager: UserManager
    
    @State var connectOpened = false
    @State var isPresentInfo = false
    
    @Binding var contact: Contact
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 5) {
                AvatarView(contact: contact)
                
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        if let surname = contact.surname {
                            Text(surname)
                        }
                        Text(contact.name ?? "")
                    }
                    .foregroundColor(.gray1100)
                    .font(bold20f)
                    
                    
                    if let bio = contact.bio {
                        Text(bio)
                            .font(light14f)
                            .foregroundColor(.gray800)
                            .multilineTextAlignment(.leading)
                            .lineLimit(2)
                            .padding(.vertical, 5)
                    }
                    
                }
                .padding(.leading, 8)
            }
            HStack {
                
                Button(action: {
                    userManager.like(user: contact) {
                        withAnimation(.bouncy) {
                            if let myUid = userManager.user?.uid {
                                if contact.likes.contains(myUid) {
                                    contact.likes.removeAll(where: { $0 == myUid })
                                } else {
                                    contact.likes.append(myUid)
                                }
                            }
                        }
                    }
                }) {
                    let liked = contact.likes.contains(userManager.user?.uid ?? "")
                    HStack(spacing: 2) {
                        Image(systemName: liked ? "heart.fill" : "heart")
                            .foregroundColor(liked ? .red : .gray800)
                        if !contact.likes.isEmpty {
                            Text(contact.likes.count.description)
                                .font(semiBold14f)
                                .foregroundColor(.gray900)
                                .transition(.move(edge: .trailing))
                        }
                    }
                }
                .frame(width: 55, alignment: .center)
                .buttonStyle(HighPriorityButtonStyle())
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 4) {
                        /// getting only sub categories
                        ForEach(contact.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
                            /// matching category int with categories from db
                            let category = cc.cats.filter({ $0.id == cat }).first ?? Constants.bugCat
                            Text(category.emoji + "  " + category.title)
                                .tracking(-0.5)
                                .font(semiBold12f)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 8)
                                .overlay(
                                            Capsule(style: .continuous)
                                                    .stroke(Color.gray200, lineWidth: 1)
                                        )
                                .clipShape(RoundedRectangle(cornerRadius: 25))
                                .padding(.vertical, 4)
                        }
                    }
                }
                .foregroundColor(.gray1100)
            }
            
        }
        
        .background(Color.gray10.opacity(0.1))
        .contextMenu {
              Button(action: {
                      let phone = contact.phone
                      let prefix = "tel://"
                      let phoneNumberformatted = prefix + phone
                      guard let url = URL(string: phoneNumberformatted) else { return }
                      UIApplication.shared.open(url)
                  }
              ) {
                    Text("Позвонить")
                    Image(systemName: "phone")
              }
          }
    }
}

struct ContactView_Previews: PreviewProvider {
    static let cc = ContactsController()
    
    static var previews: some View {
        ContactListView()
            .environmentObject(cc)
    }
}

struct HighPriorityButtonStyle: PrimitiveButtonStyle {
    func makeBody(configuration: PrimitiveButtonStyle.Configuration) -> some View {
        MyButton(configuration: configuration)
    }
    
    private struct MyButton: View {
        @State var pressed = false
        let configuration: PrimitiveButtonStyle.Configuration
        
        var body: some View {
            let gesture = DragGesture(minimumDistance: 0)
                .onChanged { _ in self.pressed = true }
                .onEnded { value in
                    self.pressed = false
                    if value.translation.width < 10 && value.translation.height < 10 {
                        self.configuration.trigger()
                    }
                }
            
            return configuration.label
                .opacity(self.pressed ? 0.5 : 1.0)
                .highPriorityGesture(gesture)
        }
    }
}
