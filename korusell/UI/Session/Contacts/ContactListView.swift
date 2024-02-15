//
//  ContactListView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI
import FirebaseFirestoreSwift

struct ContactListView: View {
    @EnvironmentObject var cc: ContactsController
    @EnvironmentObject var vc: SessionViewController
    @EnvironmentObject var userManager: UserManager
    @State var collapsed = false
    @Binding var selectedContact: Contact?
    let columns = [GridItem(.flexible())]
    
    @State var showBlock: Bool = false
    @State var showReport: Bool = false
    @State var blockingContact: Contact? = nil
    
    var body: some View {
        List {
            if cc.contacts.isEmpty && cc.selectedCategory == nil && cc.selectedSubcategory == nil && cc.selectedCities.isEmpty {
                VStack(spacing: 15) {
                    Text("🙈 Список пуст...")
                    Text("Потяни 👇 вниз чтобы обновить")
                }
                .foregroundColor(.gray300)
                .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                .listRowSeparator(.hidden)
                .listRowBackground(Color.app_white)
            } else if cc.contacts.isEmpty && (cc.selectedCategory != nil || cc.selectedSubcategory != nil) {
                Text("🙈 Список пуст...")
                    .foregroundColor(.gray300)
                    .frame(maxWidth: .infinity, maxHeight: UIScreen.main.bounds.height, alignment: .center)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.app_white)
            } else {
                ForEach(cc.contacts
                    .filter({ !$0.blockedBy.contains(userManager.user?.id ?? "🇰🇵")})
                    .filter({ $0.reports.isEmpty })
                ) { contact in
                    ZStack {
                        NavigationLink(tag: contact, selection: $selectedContact, destination: {
                            ContactDetailsView(user: contact)
                        }) {
                            EmptyView()
                        }
                        .hidden()
                        ContactView(contact: contact)
                    }
                    .listRowBackground(Color.app_white)
                    .onTapGesture {
                        self.selectedContact = contact
                    }
//                    .alertPatched(isPresented: $showBlock) {
//                        Alert(title: Text("Блокировка Пользователя"), message:
//                                Text("Вы уверены что хотите заблокировать Пользователя?"),
//                              primaryButton: .destructive(Text("Заблокировать"), action: {
//                            if let uid = userManager.user?.uid, let blockingContact  {
//                                userManager.blockOrReport(blocker: uid, userId: blockingContact.uid) {
//                                    cc.contacts.removeAll(where: { $0.uid ==  blockingContact.uid})
//                                    self.blockingContact = nil
//                                }
//                            }
//                        }),
//                              secondaryButton: .cancel(Text("Отмена"), action: {
//                            showBlock = false
//                        }))
//                    }
//                    .alertPatched(isPresented: $showReport) {
//                        Alert(title: Text(""), message:
//                                Text("Вы уверены что хотите пожаловаться на Пользователя?"),
//                              primaryButton: .destructive(Text("Пожаловаться"), action: {
//                            if let uid = userManager.user?.uid, let blockingContact {
//                                userManager.blockOrReport(reporter: uid, userId: blockingContact.uid) {
//                                    cc.contacts.removeAll(where: { $0.uid ==  blockingContact.uid})
//                                    self.blockingContact = nil
//                                }
//                            }
//                        }),
//                              secondaryButton: .cancel(Text("Отмена"), action: {
//                            showReport = false
//                        }))
//                    }
//                    .swipeActions(edge: .leading, allowsFullSwipe: false) {
//                        Button(action: {
//                            blockingContact = contact
//                            showBlock = true
//                        }) {
//                            Label("Заблокировать", systemImage: "hand.raised.fill")
//                        }.tint(.orange)
//                        Button(action: {
//                            blockingContact = contact
//                            showReport = true
//                        }) {
//                            Label("Пожаловаться", systemImage: "exclamationmark.bubble.fill")
//                        }.tint(.red)
//                    }
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        if contact.phoneIsAvailable ?? false {
                            Button(action: {
                                PhoneHelper.shared.call(contact.phone)
                            }) {
                                Label("звонок", systemImage: "phone.fill")
                            }.tint(.green)
                            Button(action: {
                                PhoneHelper.shared.sendSMS(contact.phone)
                            }) {
                                Label("СМС", systemImage: "message.fill")
                            }.tint(.blue)
                        }
                    }
                }
                
                Spacer(minLength: 100)
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color.app_white)
            }
        }
        .listStyle(.plain)
        .refreshable {
            //                if cc.selectedCategory == nil && (cc.selectedCities.isEmpty || cc.selectedCities.contains(0)) {
            if cc.selectedCategory == nil {
                cc.selectedCities = []
                cc.getCats()
                cc.getUsers()
                cc.getCities()
                print("refreshing...")
            }
        }
        .padding(.top, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .background(Color.app_white)
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .onAppear {
            withAnimation {
                vc.showBottomBar = true
            }
        }
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        //        ContactListView()
        ContactsScreen()
            .environmentObject(ContactsController())
    }
}
