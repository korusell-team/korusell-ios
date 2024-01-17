//
//  ActionButton.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/15.
//

import SwiftUI

struct ActionButton: View {
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(semiBold18f)
                .foregroundColor(.app_white)
                .padding(.vertical, 18)
                .frame(maxWidth: .infinity)
                .background(Color.gray900)
                .cornerRadius(18)
        }
    }
}

struct ActionButtonLink: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(semiBold18f)
            .foregroundColor(.app_white)
            .padding(.vertical, 18)
            .frame(maxWidth: .infinity)
            .background(Color.gray900)
            .cornerRadius(18)
    }
}

struct ActionButton_Previews: PreviewProvider {
    static var previews: some View {
        ActionButton(title: "Blue Button") {
            print("hello!")
        }
    }
}
