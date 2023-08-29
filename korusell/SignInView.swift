//
//  SignInView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/04.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @StateObject var viewModel = OTPViewModel()
    
    @State var phone = ""
    @State var code = ""
    @State var CODE = ""
    @State var showCodeWindow = false
    
    @FocusState var focusedField
    @Namespace private var animation
    @AppStorage("log_Status") var status = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    if !showCodeWindow {
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
                        .cornerRadius(25)
                        .matchedGeometryEffect(id: "field", in: animation)
                        
                    } else {
                        OTPView(viewModel: viewModel, animation: animation)
                        
                    }
                    
                    //                Button(action: test) {
                    Button(action: showCodeWindow ? verifyCode : signIn) {
                        Text(showCodeWindow ? "Войти" : "Получить СМС")
                            .font(footnoteFont)
                            .foregroundColor(.white)
                            .padding(12)
                            .background(Color.action)
                            .cornerRadius(18)
                        
                    }
                    .padding()
                    .disabled(!showCodeWindow && phone.count < 11)
                    .opacity(!showCodeWindow && phone.count < 11 ? 0.5 : 1)
                }
                
                if !showCodeWindow {
                    VStack {
                        Spacer()
                        Button(action: resend) {
                            Text("Отправить код еще раз")
                        }
                    }
                    .padding(20)
                }
            }
            .padding(.horizontal, 22)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.bg)
        }
    }
    
    private func test() {
        withAnimation {
            showCodeWindow.toggle()
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
    
    private func signIn() {
        // disable when you need to test with real device
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let properPhone = "+8210" + self.phone.replacingOccurrences(of: " - ", with: "")
        PhoneAuthProvider.provider().verifyPhoneNumber(properPhone, uiDelegate: nil) { CODE, error in
            if let error {
                print(error)
                return
            }
            self.CODE = CODE ?? ""
            print(self.CODE)
            withAnimation {
                self.showCodeWindow = true
            }
            
        }
        print(properPhone)
    }
    
    // TODO: Create this function
    private func resend() {
        
    }
    
    private func verifyCode() {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: viewModel.otpField)
        
        Auth.auth().signIn(with: credential) { (result, err) in
            if let err {
                print(err)
                return
            }
            
            
            print(result)
            
            withAnimation {
                self.status = true
                
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}

//continue firebase auth
