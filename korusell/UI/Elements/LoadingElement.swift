//
//  LoadingElement.swift
//  korusell
//
//  Created by Sergey Li on 12/10/23.
//

import SwiftUI

struct LoadingElement: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.2)
            VStack {
                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color.white))
            }
            .frame(width: 50, height: 50)
            .background(Blur(style: .systemUltraThinMaterialDark))
            .cornerRadius(10)
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).ignoresSafeArea()
    }
}

#Preview {
    LoadingElement()
}
