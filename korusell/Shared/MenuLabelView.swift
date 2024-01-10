//
//  MenuLabelView.swift
//  korusell
//
//  Created by Sergey Li on 12/10/23.
//

import SwiftUI

struct MenuLabelView: View {
    let title: String
    var subtitle: String? = nil
    let icon: String
    let bgColor: Color
    
    var body: some View {
        HStack(alignment: .center) {
            Image(systemName: icon)
                .foregroundColor(.app_white)
                .padding(4)
                .background(bgColor)
                .clipShape(RoundedRectangle(cornerRadius: 6))
                .padding(.trailing, 8)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                if let subtitle {
                    Text(subtitle)
                        .foregroundColor(.gray600)
                        .font(bold17f)
                }
            }
        }
        .font(regular17f)
        
        //        Label(
//            title: {
//                VStack(alignment: .leading, spacing: 2) {
//                    Text(title)
//                    if let subtitle {
//                        Text(subtitle)
//                            .foregroundColor(.gray600)
//                            .font(bold17f)
//                    }
//                }
//                
//            },
//            icon: {
//                Image(systemName: icon)
//                    .foregroundColor(.app_white)
//                    .padding(4)
//                    .background(bgColor)
//                    .clipShape(RoundedRectangle(cornerRadius: 6))
//                
//            }
//        )
//        .font(regular17f)
    }
}

//#Preview {
//    MenuLabelView()
//}
