//
//  BackButton.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/31.
//

import SwiftUI

struct BackButton: View {
    let action: () -> Void
    var hidden: Bool = false
    var color: Color = Color.app_white
    var title: String? = nil
    
    var body: some View {
        if !hidden {
            Button(action: action) {
                HStack {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 10, height: 20)
                    if let title {
                        Text(title)
                    }
                }
                .foregroundColor(color)
                .shadow(radius: 1, x: 1, y: 1)
            }
        }
    }
}

extension UINavigationController {
    // MARK: Allows to Swipe to go back for Navigation View even when stock Back Button is hidden
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            BackButton(action: {}, title: "Контакты")
        }
    }
}
