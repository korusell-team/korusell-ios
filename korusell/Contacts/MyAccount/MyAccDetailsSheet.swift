//
//  MyAccDetailsSheet.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/14.
//

import SwiftUI
import PopupView

struct MyAccDetailsSheet: View {
    @EnvironmentObject var userManager: UserManager
    @GestureState var gestureOffset: CGFloat = 0
    @State var offset: CGFloat = 0
    @State var lastOffset: CGFloat = 0
    @State var expanded: Bool = false
    @State var editPhonePresented: Bool = false
    
    let small: CGFloat =  UIScreen.main.bounds.height * 0.6
    
    var body: some View {
        let user = userManager.user!
        ZStack(alignment: .bottom) {
            GeometryReader { proxy -> AnyView in
                let height = proxy.frame(in: .global).height
                return AnyView(
                    ZStack {
                        Color.white
                            .clipShape(RoundedCorner(radius: 25, corners: [.topLeft, .topRight]))
                            .shadow(color: .black.opacity(0.1), radius: 10)
                        
                        VStack(spacing: 0) {
                            SheetDragger()
                            ScrollView(showsIndicators: false) {
                                VStack(alignment: .leading, spacing: 20) {
                                    HStack {
                                        Text(user.name ?? "" + " " + (user.surname ?? ""))
                                            .font(title2Font)
                                        Spacer()
                                        Button(action: {
                                            editPhonePresented = true
                                        }) {
                                            Image("ic-phone")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        }
                                        .popup(isPresented: $editPhonePresented) {
                                            EditPhoneView(editPhonePresented: $editPhonePresented)
                                        } customize: {
                                            $0
                                                .type (.floater())
                                                .position(.top)
                                                .dragToDismiss(true)
                                                .closeOnTapOutside(true)
                                                .backgroundColor(.black.opacity(0.2))
                                        }
                                        
                                        
                                        Button(action: sendSMS) {
                                            Image("ic-sms")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 50, height: 50)
                                        }
                                    }
                                    
                                    ScrollView(.horizontal, showsIndicators: false) {
                                        HStack {
                                            ForEach(0..<user.categories.count, id:\.self) { index in
                                                SmallLabelView(title: user.categories[index])
                                            }
                                            ForEach(0..<user.subcategories.count, id:\.self) { index in
                                                SmallLabelView(title: user.subcategories[index])
                                            }
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    if !user.cities.isEmpty {
                                        ScrollView(.horizontal, showsIndicators: false) {
                                            HStack {
                                                ForEach(0..<user.cities.count, id:\.self) { index in
                                                    LabelView(title: user.cities[index], isSelected: true)
                                                }
                                            }
                                        }
                                    }
                                    //TODO: set proper links prefixes and sufixes
                                    VStack(alignment: .leading, spacing: 10) {
                                        EditableSocialButton(type: .instagram, title: user.instagram)
                                        EditableSocialButton(type: .telegram, title: user.telegram)
                                        EditableSocialButton(type: .kakao, title: user.kakao)
                                        EditableSocialButton(type: .youtube, title: user.youtube)
                                        
                                    }
                                    .padding(.bottom)
                                    
                                    VStack(alignment: .leading, spacing: 10) {
                                        Text("О себе:")
                                            .bold()
                                        
                                        Text(user.bio ?? "")
                                    }
                                    .font(bodyFont)
                                    .padding(.bottom)
                                    
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
                                    Spacer(minLength: 300)
                                }
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
                )
            }.ignoresSafeArea(.all, edges: .bottom)
            
            /// opacity gradient
            //            LinearGradient(colors: [.clear, .white, .white, .white], startPoint: .top, endPoint: .bottom)
            //                .frame(maxWidth: .infinity)
            //                .frame(height: 200)
            //                .contentShape(HitTestingShape())
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
