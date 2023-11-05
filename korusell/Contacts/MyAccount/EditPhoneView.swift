//
//  EditPhoneView.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/14.
//

import SwiftUI

struct EditPhoneView: View {
    @FocusState var focusedField
    @EnvironmentObject var userManager: UserManager
    @State var phone: String = ""
    @Binding var editPhonePresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text("( 010 ) ")
                    .foregroundColor(.gray500)
                    .bold()
                TextField("Номер телефона", text: $phone)
                    .textContentType(.telephoneNumber)
                    .keyboardType(.numberPad)
                    .onChange(of: phone) { phone in
                        switcher(phone: phone)
                    }
                Spacer()
            }
            .padding()
            .background(Color.app_white)
            .cornerRadius(25)
            .padding(.horizontal, 30)
            .padding()
            
            BlueButton(title: "Сохранить") {
                let properPhone = "+8210" + self.phone.replacingOccurrences(of: " - ", with: "")
                userManager.user!.phone = properPhone
                editPhonePresented = false
                userManager.updateUser()
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width - 60)
        .padding(.vertical, 100)
        .background(Color.bg)
        .cornerRadius(30)
        .onAppear(perform: setCurrentPhone)
    }
    
    private func setCurrentPhone() {
        guard let user = userManager.user else { return }
        let myPhone = user.phone
        if myPhone.contains("+8210") {
            let eight = String(myPhone.suffix(8))
            self.phone = String(eight.prefix(4)) + " - " + String(eight.suffix(4))
        } else {
            self.phone = myPhone
        }
    }
    
    private func switcher(phone: String) {
        if phone.count == 4 {
            // without spaces?
            self.phone = self.phone.appending(" - ")
        } else if phone.count == 6 {
            self.phone = String(self.phone.dropLast(3))
        } else if phone.count == 11 {
            self.focusedField = true
        } else if phone.count > 11 {
            self.phone = String(self.phone.dropLast())
        }
    }
}

struct EditPhoneView_Previews: PreviewProvider {
    static var previews: some View {
        EditPhoneView(editPhonePresented: .constant(true))
            .environmentObject(ContactsController())
    }
}
