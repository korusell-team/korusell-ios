//
//  OTPView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/22.
//

import SwiftUI

struct OTPView: View {
    @ObservedObject var viewModel: OTPViewModel
    let animation: Namespace.ID
    @State var isFocused = false
    
//    let textBoxWidth: CGFloat = 40
//    let textBoxHeight: CGFloat = 50
    let textBoxWidth = UIScreen.main.bounds.width / 8.5
    let textBoxHeight = UIScreen.main.bounds.width / 7
    let spaceBetweenBoxes: CGFloat = 11
    let paddingOfBox: CGFloat = 1
    var textFieldOriginalWidth: CGFloat {
        (textBoxWidth*6)+(spaceBetweenBoxes*3)+((paddingOfBox*2)*3)
    }
    
    var body: some View {
            ZStack {
                HStack (spacing: spaceBetweenBoxes){
                    otpText(text: viewModel.otp1)
                    otpText(text: viewModel.otp2)
                    otpText(text: viewModel.otp3)
                    otpText(text: viewModel.otp4)
                    otpText(text: viewModel.otp5)
                    otpText(text: viewModel.otp6)
                }
                .matchedGeometryEffect(id: "field", in: animation)
                
                TextField("", text: $viewModel.otpField)
                    .frame(width: isFocused ? 0 : textFieldOriginalWidth, height: textBoxHeight)
                    .disabled(viewModel.isTextFieldDisabled)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .background(Color.clear)
                    .keyboardType(.numberPad)
            }.frame(maxWidth: .infinity, alignment: .center)
    }
    
    private func otpText(text: String) -> some View {
        return Text(text)
            .font(.title)
            .frame(width: textBoxWidth, height: textBoxHeight)
            .background(Color.gray100)
            .padding(paddingOfBox)
            .cornerRadius(10)
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
//            OTPView(viewModel: OTPViewModel(), animation: Namespace.ID)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.bg)
    }
}


class OTPViewModel: ObservableObject {
    @Published var otpField = "" {
        didSet {
            guard otpField.count <= 6,
                  otpField.last?.isNumber ?? true else {
                otpField = oldValue
                return
            }
        }
    }
    var otp1: String {
        guard otpField.count >= 1 else {
            return ""
        }
        return String(Array(otpField)[0])
    }
    var otp2: String {
        guard otpField.count >= 2 else {
            return ""
        }
        return String(Array(otpField)[1])
    }
    var otp3: String {
        guard otpField.count >= 3 else {
            return ""
        }
        return String(Array(otpField)[2])
    }
    var otp4: String {
        guard otpField.count >= 4 else {
            return ""
        }
        return String(Array(otpField)[3])
    }
    
    var otp5: String {
        guard otpField.count >= 5 else {
            return ""
        }
        return String(Array(otpField)[4])
    }
    
    var otp6: String {
        guard otpField.count >= 6 else {
            return ""
        }
        return String(Array(otpField)[5])
    }
    
    @Published var borderColor: Color = .black
    @Published var isTextFieldDisabled = false
    var successCompletionHandler: (()->())?
    
    @Published var showResendText = false

}
