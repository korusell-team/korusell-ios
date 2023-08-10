//
//  PasswordTextField.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/06.
//

import SwiftUI

struct PasswordTextField: View {
    @Binding var showPassword: Bool
    @Binding var password: String
    
    @FocusState var focusedField: Bool
    
    var placeholder: String
    
    var body: some View {
        HStack {
            if showPassword {
                TextField(placeholder, text: $password)
                    .focused($focusedField, equals: true)
            } else {
                SecureField(placeholder, text: $password)
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
    }
}

struct PasswordTextField_Previews: PreviewProvider {
    static var previews: some View {
        PasswordTextField(showPassword: .constant(true), password: .constant(""), placeholder: "Password")
    }
}
