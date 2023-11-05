//
//  ContactDetailsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/28.
//

import SwiftUI
import CachedAsyncImage

struct ContactDetailsView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State var page: Int = 0
    
    let contact: Contact
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .bottom) {
                    if contact.image.isEmpty {
                        ZStack(alignment: .bottom) {
                            Color.gray50
                            Image("alien")
                                .resizable()
                                .scaledToFit()
                                .frame(width: UIScreen.main.bounds.width / 1.5)
                        }
                    } else {
                        TabView(selection: $page) {
                            ForEach(0..<contact.image.count, id: \.self) { index in
                                CachedAsyncImage(url: URL(string: contact.image[index]), urlCache: .imageCache) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        ZStack(alignment: .top) {
                                            image
                                                .resizable()
                                                .scaledToFill()
                                            LinearGradient(colors: [.clear, .gray1100.opacity(0.8)], startPoint: .bottom, endPoint: .top)
                                                .frame(height: 150)
                                        }
                                        .transition(.scale(scale: 0.1, anchor: .center))
                                    case .failure:
                                        Image(systemName: "photo")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .tag(index)
                                .ignoresSafeArea()
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                    } //else
                }
                .frame(width: UIScreen.main.bounds.width, height: Size.w(390))
                .background(Color.app_white.opacity(0.01))
                .cornerRadius(20)
//                .cornerRadius(20, corners: [.bottomLeft, .bottomRight])
                
                ContactDetailsSheet(contact: contact)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        .background(Color.app_white)
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: { presentationMode.wrappedValue.dismiss() }, title: "Контакты"))
    }
}

//struct ContactDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            ContactDetailsView(contact: dummyContacts.last(where: { $0.surname == "Мун" })!)
//        }
//    }
//}
