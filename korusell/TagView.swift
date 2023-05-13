//
//  TagView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct TagView: View {
    var tag: String
    @Binding var secondText: String
    
    var body: some View {
        Button(action: {
             reset all
             may be create func for resetting all search data and category
             create observable object
            
            self.secondText = self.secondText == tag ? "" : tag
        }) {
            Text(tag)
                .font(.footnote)
                .foregroundColor(secondText == tag ? .white : .gray1000)
                .padding(.horizontal, 8)
                .padding(.vertical, 5)
                .background(secondText == tag ? Color.gray700 : Color.gray50)
                .clipShape(Capsule())
        }
        
    }
}
