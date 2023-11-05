//
//  BlueButton.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/15.
//

import SwiftUI

struct BlueButton: View {
    let title: String
    let action: () -> ()
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(regular13f)
                .foregroundColor(.white)
                .padding(12)
                .background(Color.action)
                .cornerRadius(18)
        }
    }
}

struct BlueButton_Previews: PreviewProvider {
    static var previews: some View {
        BlueButton(title: "Blue Button") {
            print("hello!")
        }
    }
}
