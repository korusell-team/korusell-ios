//
//  TagView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct TagView: View {
    @EnvironmentObject var cc: ContactsController
    var tag: String
    
    var body: some View {
        Button(action: {
            cc.text = cc.text == tag ? "" : tag
        }) {
            Text(tag)
                .font(.footnote)
                .foregroundColor(cc.text == tag ? .white : .gray1000)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(cc.text == tag ? Color.gray700 : Color.gray50)
                .clipShape(Capsule())
        }
        
    }
}
