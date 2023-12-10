//
//  ContactDetailsSheet.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/29.
//

import SwiftUI

struct ContactDetailsInfo: View {
    @EnvironmentObject var cc: ContactsController
    
    @State var aboutIsOpened = false
    
    let contact: Contact
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text((contact.name ?? "") + " " + (contact.surname ?? ""))
                        .tracking(-0.5)
                        .font(semiBold22f)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(contact.cities, id: \.self) { id in
                                if let city = cc.cities.first(where: { $0.id == id }) {
                                    Text(city.ru)
                                        .font(regular17f)
                                        .foregroundColor(.gray800)
                                        .padding(.trailing, 6)
                                }
                            }
                        }
                    }
                }
             
                Spacer()
                
                Button(action: call) {
                    Image("ic-phone")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(!contact.phoneIsAvailable.bound)
                .opacity(contact.phoneIsAvailable.bound ? 1 : 0.5)
                
                Button(action: sendSMS) {
                    Image("ic-sms")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
                .disabled(!contact.phoneIsAvailable.bound)
                .opacity(contact.phoneIsAvailable.bound ? 1 : 0.5)
            }
            .padding(.bottom, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    /// getting only sub categories
                    ForEach(contact.categories.filter({ $0 % 100 > 0  }), id: \.self) { cat in
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

            Divider().padding(.vertical, 10)
            
            if let info = contact.info, contact.info != "" {
                VStack(alignment: .leading, spacing: 6) {
                    Text("О себе:")
                        .bold()
                        .font(semiBold18f)
//                        .padding(.bottom, 6)
                    ExpandableText(text: info)
                        .lineLimit(10)
                        .collapseButton(TextSet(text: "свернуть", font: regular15f, color: .blue))
              
                }
                .padding(6)
            }
//                VStack(alignment: .leading, spacing: 0) {
//                    Text("О себе:")
//                        .bold()
//                        .padding(.bottom, 6)
//                    Text(bio)
//                        .lineLimit(7)
//                    
//                    HStack {
//                        Button(action: {
//                           aboutIsOpened = true
//                        }) {
//                            Text("...раскрыть")
//                        }
//                        .padding()
//                        .clipShape(Rectangle())
//                    }.frame(maxWidth: .infinity, alignment: .trailing)
//                }
//                .font(regular17f)
//                .sheet(isPresented: $aboutIsOpened) {
//                    ScrollView {
//                        VStack(alignment: .leading, spacing: 5) {
//                            Text("О себе:")
//                                .bold()
//                            Text(bio)
//                        }
//                        .frame(maxWidth: .infinity, alignment: .leading)
//                        .padding(.horizontal, 24)
//                        
//                    }
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
//                    .font(regular17f)
//                    .padding(.top, 30)
//                }
//            }
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(socialType.allCases) { type in
                    SocialButton(type: type, contact: contact)
                }
            }
            .padding(.vertical)

            Spacer(minLength: 200)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 13)
        .padding(.horizontal, 24)

    }

    private func call() {
        let phone = contact.phone
        let prefix = "tel://"
        let phoneNumberformatted = prefix + phone
        guard let url = URL(string: phoneNumberformatted) else { return }
        UIApplication.shared.open(url)
        //        }
    }
    
    private func sendSMS() {
        let phone = contact.phone
        let sms: String = "sms:+8210\(phone)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        //        }
    }
}


//struct ContactDetailsSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        ContactDetailsView(contact: Contact(uid: "", name: "Владимир", surname: "Мун", bio: "Habsida. Школа программирования и дизайна. С оплатой после трудоустройства!", cities: ["Сеул"], image: ["vladimir-mun", "vladimir-mun2"], categories: ["Образование"], subcategories: ["Дизайн", "Программирование"], phone: "010-1234-1234", instagram: "munvova", link: "https://habsida.com/ru", telegram: "vladimun"))
//        //        ContactDetailsSheet(contact: listOfContacts.first(where: { $0.name == "Владимир" })!)
//    }
//}

struct HitTestingShape : Shape {
    func path(in rect: CGRect) -> Path {
        return Path(CGRect(x: 0, y: 0, width: 0, height: 0))
    }
}
