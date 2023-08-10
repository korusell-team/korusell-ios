//
//  SignUpView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/06.
//

import SwiftUI

struct SignUpView: View {
    
    @State var password = ""
    @State var secondPassword = ""
    @State var phone = ""
    @State var showPassword = false
    
    @FocusState private var focusedField
    
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
            .background(Color.white)
            .cornerRadius(14)
            
            PasswordTextField(showPassword: $showPassword, password: $password, focusedField: _focusedField, placeholder: "Пароль")
            
            
            PasswordTextField(showPassword: $showPassword, password: $secondPassword, placeholder: "Пароль еще раз")
            
            Button(action: signIn) {
                Text("Зарегистрироваться")
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .padding(.horizontal, 22)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray10)
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
    
    private func signIn() {
        let properPhone = "010" + self.phone.replacingOccurrences(of: " - ", with: "")
        print(properPhone)
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
