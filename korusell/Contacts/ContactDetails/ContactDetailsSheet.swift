//
//  ContactDetailsSheet.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/29.
//

import SwiftUI

struct ContactDetailsSheet: View {
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var expanded: Bool = false
    
    let contact: Contact
    
    let small: CGFloat =  UIScreen.main.bounds.height - 390 + 60
    
    var body: some View {
        ZStack {
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView(
                    ZStack {
                        Color.white
                            .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
                            .shadow(color: .black.opacity(0.1), radius: 10)
                        
                        VStack(spacing: 0) {
                            SheetDragger()
                            VStack(alignment: .leading, spacing: 20) {
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(contact.name + " " + contact.surname)
                                            .font(title2Font)
                                        HStack {
                                            LabelView(title: contact.categories.first ?? "", isSelected: true)
                                            LabelView(title: contact.subcategories.first ?? "", isSelected: true)
                                        }
                                    }
                                    Spacer()
                                    Button(action: call) {
                                        Image("ic-phone")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                    }
                                    
                                    Button(action: sendSMS) {
                                        Image("ic-sms")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 40, height: 40)
                                    }
                                }
                                
                                Divider()
                                
                                LabelView(title: contact.cities.first ?? "", isSelected: true)
                                
                                
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 13)
                            .padding(.horizontal, 24)
                            Spacer()
                        }
                    }
                        .offset(y: height - small)
                        .offset(y: -offset > 0 ? -offset <= (height - small) ? offset : -(height - small) : 0)
                        .gesture(DragGesture().updating($gestureOffset, body: { value, out, _ in
                            out = value.translation.height
                            onChange()
                        }).onEnded({ value in
                            onEndDragGesture(height: height)
                        }))
                        .onTapGesture {
                            let maxHeight = height - small
                            withAnimation {
                                if !expanded {
                                    offset = -maxHeight
                                    lastOffset = offset
                                    expanded.toggle()
                                }
                            }
                        }
                )
            }.ignoresSafeArea(.all, edges: .bottom)
        }
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
        if let phone = contact.phone {
            let prefix = "tel://"
            let phoneNumberformatted = prefix + phone
            guard let url = URL(string: phoneNumberformatted) else { return }
            UIApplication.shared.open(url)
        }
    }
    
    private func sendSMS() {
        if let phone = contact.phone {
            let sms: String = "sms:+8210\(phone)"
            let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
        }
    }
}


struct ContactDetailsSheet_Previews: PreviewProvider {
    static var previews: some View {
        ContactDetailsView(contact: listOfContacts.first(where: { $0.name == "Владимир" })!)
//        ContactDetailsSheet(contact: listOfContacts.first(where: { $0.name == "Владимир" })!)
    }
}
