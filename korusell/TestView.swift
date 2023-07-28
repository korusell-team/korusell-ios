//
//  TestView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/12.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        ZStack {
            Color.red.frame(width: 60, height: 50)
                .cornerRadius(200, corners: [.topLeft, .topRight])
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
