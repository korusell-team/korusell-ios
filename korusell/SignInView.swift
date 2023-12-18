//
//  SignInView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/04.
//

import SwiftUI
import Firebase

struct SignInView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel = OTPViewModel()
    
    @State var phone = ""
    //    @State var code = ""
    @State var CODE = ""
    @State var showCodeWindow = false
    @State var error: String? = nil
    
    @FocusState var focusedField
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Spacer()
                
                Image(systemName: showCodeWindow ? "lock.fill" : "iphone")
                    .font(bold30f)
                    .symbolRenderingMode(.monochrome)
                    .foregroundColor(.gray500)
                    .padding()
                    .background(Color.gray100)
                    .clipShape(Circle())
                    .padding(.bottom)
                Text(showCodeWindow ? "Введите шестизначный код полученный в SMS" : "Войдите или Зарегистрируйтесь указав номер телефона")
                    .font(light14f)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.gray600)
                    .padding(.bottom)
                
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
                    .background(Color.gray100)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "field", in: animation)
                    
                } else {
                    OTPView(viewModel: viewModel, animation: animation)
                }
                
                if let error {
                    HStack {
                        Text(error)
                            .font(regular12f)
                            .foregroundColor(.red400)
                        //                                .lineLimit(1)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 25)
                }
                
                Spacer()
                
                HStack {
                    ActionButton(title: showCodeWindow ? "Войти" : "Далее", action: onButtonTap)
                        .padding()
                        .disabled(!showCodeWindow && phone.count < 11)
                        .opacity(!showCodeWindow && phone.count < 11 ? 0.5 : 1)
                }.frame(maxWidth: .infinity, alignment: .center)
                
                if showCodeWindow {
                    HStack {
                        Button(action: signIn) {
                            Text("Отправить код еще раз")
                                .foregroundColor(.gray700)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical)
                }
            }
            
            
        }
        .padding(.horizontal, 22)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray50)
        .onChange(of: viewModel.otpField) { _ in
            resetError()
        }
        .onChange(of: phone) { _ in
            resetError()
        }
        .animation(.default, value: error)
    }
    
    private func resetError() {
        if error != nil {
            self.error = nil
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
    
    private func onButtonTap() {
        showCodeWindow ? verifyCode() : signIn()
    }
    
    private func signIn() {
        // disable when you need to test with real device
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        let properPhone = "+8210" + self.phone.replacingOccurrences(of: " - ", with: "")
        PhoneAuthProvider.provider().verifyPhoneNumber(properPhone, uiDelegate: nil) { CODE, error in
            self.CODE = CODE ?? ""
            if let error {
                self.error = error.localizedDescription
                print(error)
                return
            }
            
            print(self.CODE)
            withAnimation {
                self.showCodeWindow = true
            }
        }
        print(properPhone)
    }
    
    private func verifyCode() {
        withAnimation {
            userManager.isLoading = true
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: viewModel.otpField)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error {
                self.error = error.localizedDescription
                print(error)
                userManager.isLoading = false
                return
            }
            DispatchQueue.main.async {
                userManager.handleUser()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(UserManager())
        //        @EnvironmentObject var userManager:
        //        @StateObject var viewModel = OTPViewModel()
    }
}

//continue firebase auth
