//
//  MenuLabelView.swift
//  korusell
//
//  Created by Sergey Li on 12/10/23.
//

import SwiftUI

struct MenuLabelView: View {
    let title: String
    let icon: String
    let bgColor: Color
    var body: some View {
        Label(
            title: { Text(title) },
            icon: {
                Image(systemName: icon)
                    .foregroundColor(.app_white)
                    .padding(4)
                    .background(bgColor)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                
            }
        )
        .font(regular17f)
    }
}

//#Preview {
//    MenuLabelView()
//}
