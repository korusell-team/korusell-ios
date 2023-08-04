//
//  SignInView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/04.
//

import SwiftUI

struct SignInView: View {
    
    @State var password = ""
    @State var phone = ""
    @State var showPassword = false
    
    @FocusState private var focusedField
    
    var body: some View {
        VStack {
            HStack {
                Text("( 010 ) ")
                    .foregroundColor(.gray500)
                    .bold()
                TextField("", text: $phone)
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
            
            HStack {
                if showPassword {
                    TextField("Password", text: $password)
                        .focused($focusedField, equals: true)
                } else {
                    SecureField("Password", text: $password)
                        .focused($focusedField, equals: true)
                        
                }
                Spacer()
                Button(action: {
                    self.showPassword.toggle()
                }, label: {
                    Image(systemName: showPassword ? "eye.slash" : "eye")
                        .foregroundColor(.gray700)
                        .opacity(password.isEmpty ? 0 : 1)
                    
                })
            }
            .padding()
            .background(Color.white)
            .cornerRadius(14)
            
            Button(action: signIn) {
                Text("Войти")
            }
            .buttonStyle(.bordered)
            .padding()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray10)
    }
    
    private func switcher(phone: String) {
        if phone.count == 4 {
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

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

continue firebase auth
