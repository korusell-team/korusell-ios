//
//  TagView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/13.
//

import SwiftUI

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

struct SubCatLabelView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
            .environmentObject(ContactsController())
    }
}
