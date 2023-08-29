//
//  SheetDragger.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/29.
//

import SwiftUI

struct SheetDragger: View {
    var body: some View {
        Color.black
            .opacity(0.2)
            .frame(width: 85, height: 6)
            .clipShape(Capsule())
            .padding(.top, 15)
            .padding(.bottom, 10)
    }
}

struct SheetDragger_Previews: PreviewProvider {
    static var previews: some View {
        SheetDragger()
    }
}
