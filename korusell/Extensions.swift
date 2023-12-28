//
//  Design.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/11.
//

import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
    
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }
    
    /// handling overlaying alerts!
    public func alertPatched(isPresented: Binding<Bool>, content: () -> Alert) -> some View {
        self.overlay(
            EmptyView().alert(isPresented: isPresented, content: content),
            alignment: .bottomTrailing
        )
    }
    
    
//    @ViewBuilder
//    func navigationView(back: @escaping () -> Void = {}, title: LocalizedStringKey = "", backButtonHidden: Bool = false, backButtonColor: Color = Color.white) -> some View {
//        self
////            .background(bg.ignoresSafeArea())
//            .navigationBarBackButtonHidden(true)
//            .navigationBarItems(leading: BackButton(action: back, hidden: backButtonHidden, color: backButtonColor))
//            .navigationBarTitle(Text(title).foregroundColor(.white))
//    }
    
    
}

extension Optional where Wrapped == String {
    var _bound: String? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: String {
        get {
            return _bound ?? ""
        }
        set {
            _bound = newValue.isEmpty ? nil : newValue
        }
    }
}

extension Optional where Wrapped == Bool {
    var _bound: Bool? {
        get {
            return self
        }
        set {
            self = newValue
        }
    }
    public var bound: Bool {
        get {
            return _bound ?? false
        }
        set {
            _bound = newValue
        }
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Color {
    static let bg = Color("bg")
    static let app_white = Color("app-white")
    static let gray10 = Color("gray-10")
//    static let gray50 = Color("gray-50")
    static let gray100 = Color("gray-100")
//    static let gray200 = Color("gray-200")
    static let gray300 = Color("gray-300")
    static let gray400 = Color("gray-400")
    static let gray500 = Color("gray-500")
    static let gray600 = Color("gray-600")
    static let gray700 = Color("gray-700")
    static let gray800 = Color("gray-800")
    static let gray900 = Color("gray-900")
    static let gray1000 = Color("gray-1000")
    static let gray1100 = Color("gray-1100")
    
    static let green10 = Color("green-10")
    static let green50 = Color("green-50")
    static let green100 = Color("green-100")
    static let green200 = Color("green-200")
    static let green300 = Color("green-300")
    static let green400 = Color("green-400")
    static let green500 = Color("green-500")
    static let green600 = Color("green-600")
    static let green700 = Color("green-700")
    static let green800 = Color("green-800")
    static let green900 = Color("green-900")
    
    static let blue10 =  Color("blue-10")
    static let blue50 =  Color("blue-50")
    static let blue100 = Color("blue-100")
    static let blue200 = Color("blue-200")
    static let blue300 = Color("blue-300")
    static let blue400 = Color("blue-400")
    static let blue500 = Color("blue-500")
    static let blue600 = Color("blue-600")
    static let blue700 = Color("blue-700")
    static let blue800 = Color("blue-800")
    static let blue900 = Color("blue-900")
    static let blue1000 = Color("blue-1000")
    
    static let red50 =  Color("red-50")
    static let red100 = Color("red-100")
    static let red200 = Color("red-200")
    static let red300 = Color("red-300")
    static let red400 = Color("red-400")
    static let red500 = Color("red-500")
    static let red600 = Color("red-600")
    static let red700 = Color("red-700")
    static let red800 = Color("red-800")
    static let red900 = Color("red-900")
    static let red1000 = Color("red-1000")
    
    static let yellow50 =  Color("yellow-50")
    static let yellow100 = Color("yellow-100")
    static let yellow200 = Color("yellow-200")
    static let yellow300 = Color("yellow-300")
    static let yellow400 = Color("yellow-400")
    static let yellow500 = Color("yellow-500")
    static let yellow600 = Color("yellow-600")
    static let yellow700 = Color("yellow-700")
    static let yellow800 = Color("yellow-800")
    static let yellow900 = Color("yellow-900")
    static let yellow1000 = Color("yellow-1000")
    
    
    static let accent = Color("accent")
    static let accent_light = Color("accent-light")
    static let action = Color("action")
    static let gray50 = Color("gray50")
    static let gray200 = Color("gray200")
    
}
