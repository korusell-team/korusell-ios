//
//  TagView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

struct EmoLabelView: View {
    var title: String
    var isSelected: Bool = false
    var emo: String? = nil
    
    var body: some View {
        HStack {
            if let emo {
                Text(emo)
            }
            Text(title)
                .font(subheadFont)
                .foregroundColor(isSelected ? .gray50 : .gray900)
                
        }
        .padding(.vertical, 8)
        .padding(.horizontal, 15)
        .background(isSelected ? Color.gray700 : Color.white)
        .cornerRadius(20)
    }
}

struct LabelView: View {
    var title: String
    var isSelected: Bool = false
    
    var body: some View {
        Text(title)
            .font(subheadFont)
            .foregroundColor(isSelected ? .gray50 : .gray900)
            .padding(.vertical, 8)
            .padding(.horizontal, 15)
            .background(isSelected ? Color.gray700 : Color.white)
            .cornerRadius(20)
    }
}

struct SmallLabelView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(footnoteFont)
            .foregroundColor(.gray50)
            .padding(.vertical, 5)
            .padding(.horizontal, 12)
            .background(Color.gray700)
            .cornerRadius(20)
    }
}

struct SubCatLabelView_Previews: PreviewProvider {
    static var previews: some View {
        SmallLabelView(title: "sasa")
//        ContactsScreen()
//            .environmentObject(ContactsController())
    }
}
