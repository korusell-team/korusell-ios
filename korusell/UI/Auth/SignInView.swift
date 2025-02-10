//
//  SignInView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/04.
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    @EnvironmentObject var userManager: UserManager
    @StateObject var viewModel = OTPViewModel()
    
    @State var phone = ""
    //    @State var code = ""
    @State var CODE = ""
    @State var showCodeWindow = false
    @State var error: String? = nil
    @State var isLoading: Bool = false
    
    @State var privacyAgree = false
    @State var contentAgree = false
    @State var showContentPolicy = false
    @State var showPrivcacyPolicy = false
    
    @FocusState var focusedField
    @Namespace private var animation
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Button(action: {
                        withAnimation {
                            showCodeWindow = false
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(regular20f)
                            .foregroundColor(.gray800)
                    })
                    
                    Spacer()
                }.opacity(showCodeWindow ? 1 : 0)
                
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
                        TextField("+82100001111", text: $phone)
                            .textContentType(.telephoneNumber)
                            .keyboardType(.phonePad)
                            .onChange(of: self.phone) { phone in
                                self.phone = phone.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
                            }
                        Spacer()
                    }
                    .padding()
                    .background(Color.gray100)
                    .cornerRadius(15)
                    .matchedGeometryEffect(id: "field", in: animation)
                    
//                    Text("Пример: +821012341234")
//                        .foregroundColor(.gray600)
//                        .padding(.horizontal, 18)
//                        .padding(.bottom)
                    
                    
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
                    .padding(.top, 10)
                    .padding(.horizontal, 15)
                    .onChange(of: viewModel.otpField) { _ in
                        self.error = ""
                    }
                    .onChange(of: phone) { _ in
                        self.error = ""
                    }
                }
                
                Spacer()
                
                if !showCodeWindow {
                    VStack(alignment: .center) {
                        Text("Авторизуясь, Вы соглашаетесь с **Политикой нежелательного контента** и с **Политикой конфиденциальности**")
                            .font(light14f)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.gray700)
                            .onTapGesture {
                                showContentPolicy = true
                            }
                            .sheet(isPresented: $showContentPolicy, content: {
                                WebView(url: URL(string: "https://wide-arthropod-bad.notion.site/ethnogram-9da27521cf1b4775825e9b85ad255790?pvs=4")!)
                            })
                    }.frame(maxWidth: .infinity)

//                    Button(action: {
//                        contentAgree.toggle()
//                    }) {
//                        (Text(Image(systemName: contentAgree ? "checkmark.square" : "square")) + Text("  Да, я согласен с Политикой нежелательного контента"))
//                            .foregroundColor(.gray1000)
//                    }
//                    
//                    HStack {
//                        Button(action: {
//                            showContentPolicy = true
//                        }, label: {
//                            Text("Прочитать")
//                                .font(light14f)
//                        })
//                        .sheet(isPresented: $showContentPolicy, content: {
//                            WebView(url: URL(string: "https://wide-arthropod-bad.notion.site/00bc2c43d10449a68463233a80007ee6?pvs=4")!)
//                        })
//                    }.frame(maxWidth: .infinity, alignment: .trailing)
//                        .padding(.bottom)
//                    
//                    Button(action: {
//                        privacyAgree.toggle()
//                    }) {
//                        (Text(Image(systemName: privacyAgree ? "checkmark.square" : "square")) + Text("  Да, я согласен с Политикой конфиденциальности"))
//                            .foregroundColor(.gray1000)
//                    }
//                    
//                    HStack {
//                        Button(action: {
//                            showPrivcacyPolicy = true
//                        }, label: {
//                            Text("Прочитать")
//                                .font(light14f)
//                        })
//                        .sheet(isPresented: $showPrivcacyPolicy, content: {
//                            WebView(url: URL(string: "https://wide-arthropod-bad.notion.site/4d3f3c37114243bcb9bd97ee1646bc11?pvs=4")!)
//                        })
//                    }.frame(maxWidth: .infinity, alignment: .trailing)
                }
                

                
                HStack {
                    ActionButton(title: showCodeWindow ? "Войти" : "Далее", action: onButtonTap)
                        .padding()
                        .disabled(!showCodeWindow && !validatePhone())
//                        .disabled(!privacyAgree || !contentAgree)
                        .opacity(!showCodeWindow && !validatePhone() ? 0.5 : 1)
//                        .opacity(!privacyAgree || !contentAgree ? 0.5 : 1)
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
            .padding(.horizontal, 22)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray50)
            
            if isLoading {
                LoadingElement()
            }
        }
        .onChange(of: viewModel.otpField) { _ in
            resetError()
        }
        .onChange(of: phone) { _ in
            resetError()
        }
        .animation(.default, value: error)
    }
    
    private func validatePhone() -> Bool {
        self.phone.count >= 8
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
        } else if phone.count == 11 && !self.phone.contains(" - ") {
            // MARK: Case when phone paste from keyboard suggestions... (need tests)
            let full = String(self.phone.dropFirst(3))
            let firstPart = full.dropLast(4)
            let secondPart = full.dropFirst(4)
            self.phone = ""
            self.phone.append(String(firstPart))
            self.phone.append(" - ")
            self.phone.append(String(secondPart))
            self.focusedField = true
        } else if phone.count > 11 {
            self.phone = String(self.phone.dropLast())
        }
    }
    
    private func onButtonTap() {
        showCodeWindow ? verifyCode() : signIn()
    }
    
    private func signIn() {
        //MARK: disable when you need to test with real device
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        self.isLoading = true
        self.phone = self.phone.starts(with: "010") ? self.phone.replacingOccurrences(of: "010", with: "+8210") : self.phone
        PhoneAuthProvider.provider().verifyPhoneNumber(self.phone) { CODE, error in
            self.isLoading = false
            self.CODE = CODE ?? ""
            if let error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.missingClientIdentifier.rawValue:
                    self.error = "Что то пошло не так... 😖"
                case AuthErrorCode.captchaCheckFailed.rawValue:
                    self.error = "Вы не прошли Capthca проверку 🔒"
                case AuthErrorCode.invalidPhoneNumber.rawValue:
                    self.error = "Неверный номер телефона ☎️"
                case AuthErrorCode.invalidVerificationCode.rawValue:
                    self.error = "Неверный код подтверждения 🔒"
                case AuthErrorCode.tooManyRequests.rawValue:
                    self.error = "Вы отправили слишком много запросов 🙈"
                case AuthErrorCode.networkError.rawValue:
                    self.error = "Проблемы с сетью... 🛰️"
                default:
                    self.error = "Что то пошло не так... 😖"
                }
                print(err)
                return
            }
            
            print(self.CODE)
            withAnimation {
                self.showCodeWindow = true
            }
        }
        print(self.phone)
    }
    
    private func verifyCode() {
        
        withAnimation {
            self.isLoading = true
//            userManager.isLoading = true
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: viewModel.otpField)
        
        Auth.auth().signIn(with: credential) { (result, error) in
            if let error {
                let err = error as NSError
                switch err.code {
                case AuthErrorCode.wrongPassword.rawValue:
                    self.error = "Неверный пароль 🔒"
                case AuthErrorCode.invalidPhoneNumber.rawValue:
                    self.error = "Неверный номер телефона ☎️"
                case AuthErrorCode.tooManyRequests.rawValue:
                    self.error = "Вы отправили слишком много запросов 🙈"
                case AuthErrorCode.networkError.rawValue:
                    self.error = "Проблемы с сетью... 🛰️"
                case AuthErrorCode.invalidVerificationCode.rawValue:
                    self.error = "Неверный код подтверждения 🔒"
                default:
                    self.error = "Что то пошло не так... 😖"
                }
                print(err)
                isLoading = false
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
