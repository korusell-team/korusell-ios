//
//  ContactDetailsSheet.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/29.
//

import SwiftUI
import FirebaseFirestoreSwift

extension ForEach where Data.Element: Hashable, ID == Data.Element, Content: View {
    init(values: Data, content: @escaping (Data.Element) -> Content) {
        self.init(values, id: \.self, content: content)
    }
}

struct ContactDetailsSheet: View {
    @EnvironmentObject var cc: ContactsController
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var expanded: Bool = false
    @State var maxHeight: CGFloat = 130
    
    let contact: Contact
    
    let small: CGFloat =  UIScreen.main.bounds.height * 0.6
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text((contact.name ?? "") + " " + (contact.surname ?? ""))
                        .tracking(-0.5)
                        .font(semiBold22f)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 0) {
                            ForEach(contact.cities, id: \.self) { city in
                                Text(city)
                                    .font(regular17f)
                                    .foregroundColor(.gray800)
                                    .padding(.trailing, 6)
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
                
                Button(action: sendSMS) {
                    Image("ic-sms")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                }
            }
            .padding(.bottom, 5)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(contact.categories, id: \.self) { cat in
                        let category = cc.cats.filter({ $0.id == cat }).first!
                        Text(category.title)
                            .padding(3)
//                            .background(category.p_id > 0 ? Color.clear : Color.gray100)
//                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .font(category.p_id > 0 ? light14f : semiBold16f)
//                            .font(category.p_id > 0 ? regular13f : semiBold14f)
                            .foregroundColor(category.p_id > 0 ? .gray600 : .gray800)
                    }
                }
            }

            Divider().padding(.vertical, 10)
            
            if let bio = contact.bio {
                VStack(alignment: .leading, spacing: 5) {
                    Text("О себе:")
                        .bold()
                    Text(contact.bio ?? "")
                    
                    HStack {
                        Button(action: {
                            withAnimation {
                                self.maxHeight = maxHeight == 130 ? 400 : 130
                            }
                        }) {
                            Image(systemName: "chevron.down")
                                .rotationEffect(.degrees(maxHeight == 130 ? 0 : 180))
                                .padding(.top, 5)
                                .padding(.bottom, 15)
                        }
                        .clipShape(Circle())
                    }.frame(maxWidth: .infinity, alignment: .top)
                }
                .font(regular17f)
                .frame(maxHeight: maxHeight)
            }
            
            //TODO: set proper links prefixes and sufixes
            VStack(alignment: .leading, spacing: 10) {
                SocialButton(type: .instagram, title: contact.instagram)
                SocialButton(type: .telegram, title: contact.telegram)
                SocialButton(type: .kakao, title: contact.kakao)
                SocialButton(type: .youtube, title: contact.youtube)
                SocialButton(type: .link, title: contact.link)
                SocialButton(type: .tiktok, title: contact.tiktok)
            }
            .padding(.vertical)
            
           
            
            //                                    if !contact.places.isEmpty {
            //                                        Text("Места:")
            //                                            .font(bodyFont)
            //                                            .bold()
            //
            //                                        let columns = [GridItem(.flexible(maximum: 100)), GridItem(.flexible(maximum: 100)), GridItem(.flexible()), GridItem(.flexible())]
            //
            //                                        LazyVGrid(columns: columns) {
            //                                            ForEach(contact.places) { place in
            //                                                VStack(alignment: .center) {
            //                                                    ZStack {
            //                                                        if let image = place.image {
            //                                                            Image(image)
            //                                                                .resizable()
            //                                                                .scaledToFit()
            //                                                                .cornerRadius(20)
            //                                                        } else {
            //                                                            RoundedRectangle(cornerRadius: 20)
            //                                                                .fill(Color.gray300)
            //                                                        }
            //                                                    }
            //                                                    Text(place.name)
            //                                                        .multilineTextAlignment(.center)
            //                                                        .font(caption1Font)
            //                                                        .lineLimit(2)
            //                                                }
            //                                                .frame(maxHeight: 120, alignment: .top)
            //                                            }
            //                                        }
            //                                    }
            Spacer(minLength: 200)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 13)
        .padding(.horizontal, 24)

    }
    
    private func onEndDragGesture(height: CGFloat) {
        let maxHeight = height - small - (Size.safeArea().top + Size.statusBarHeight)
        withAnimation {
            if self.expanded {
                if -offset < maxHeight * 0.9 {
                    self.expanded = false
                    offset = 0
                } else {
                    self.expanded = true
                    offset = -maxHeight
                }
            } else {
                if -offset > maxHeight * 0.1 {
                    self.expanded = true
                    offset = -maxHeight
                } else {
                    self.expanded = false
                    offset = 0
                }
            }
        }
        lastOffset = offset
    }
    
    func onChange() {
        DispatchQueue.main.async {
            self.offset = gestureOffset + lastOffset
        }
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
