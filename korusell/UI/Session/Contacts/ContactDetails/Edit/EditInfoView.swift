//
//  EditInfoView.swift
//  korusell
//
//  Created by Sergey Li on 12/29/23.
//

import SwiftUI

struct EditInfoView: View {
    @Binding var info: String?
    var textLimit: Int = 800
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
//            Text("О себе:")
//                .font(regular17f)
            ZStack {
                TextEditor(text: $info.bound)
                //                .focused($focusedField, equals: true)
                Text(info.bound).opacity(0).padding(8)
            }
            
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .background(Color.white)
//            .overlay(
//                RoundedRectangle(cornerRadius: 4)
//                    .stroke(Color.gray200, lineWidth: 0.2)
//            )
            .font(regular17f)
            .onChange(of: info.bound) { newValue in
                info = newValue.count > textLimit ? String(newValue.prefix(textLimit)) : newValue
            }
            
            HStack {
                Text("\(info?.count ?? 0)/\(textLimit)")
                    .font(regular15f)
                    .foregroundColor(.gray600)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.horizontal, 5)
        }
        .frame(maxHeight: Size.w(250))
    }
}

//#Preview {
//    EditInfoView()
//}
