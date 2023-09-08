//
//  ContactDetailsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/28.
//

import SwiftUI

struct ContactDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    @State var page: Int = 0
    
    let contact: Contact
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    if contact.image.isEmpty {
                        ZStack(alignment: .bottom) {
                            Color.white
                            Image("alien")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 1.5)
                        }
                    } else {
                        TabView(selection: $page) {
                            ForEach(0..<contact.image.count, id: \.self) { index in
                                ZStack(alignment: .top) {
                                    Image(contact.image[index])
                                        .resizable()
                                        .scaledToFill()
                                    LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                                        .frame(height: 150)
                                }
                                
                                    .tag(index)
                                    .ignoresSafeArea()
                                
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    }
 
                    if contact.image.count > 1 {
                        HStack(alignment: .center, spacing: 4) {
                            ForEach(0..<contact.image.count, id: \.self) { index in
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(Color.white.opacity(page == index ? 1 : 0.5))
                                    .frame(width: 4 + (page == index ? 13 : 0), height: 4)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 24)
                        .padding(.bottom, 70)
                    }
                }
                .background(Color.white.opacity(0.01))
                .frame(maxHeight: 390, alignment: .center)
//                .offset(y: -30)
                Spacer()
            }
            
            ContactDetailsSheet(contact: contact)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .animation(.default, value: page)
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { presentationMode.wrappedValue.dismiss() }, title: "Контакты"))
    }
}

struct ContactDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContactDetailsView(contact: listOfContacts.last(where: { $0.surname == "Ким" })!)
        }
    }
}
