//
//  AccTextField.swift
//  korusell
//
//  Created by Sergey Li on 12/29/23.
//

import SwiftUI

struct AccTextField: View {
    let title: String
    var placeholder: String = ""
    @Binding var binding: String
    var textLimit: Int? = nil
    
    var body: some View {
        HStack(alignment: .center, spacing: 3) {
            TextField(placeholder, text: $binding)
                .font(regular15f)
                .onChange(of: binding) { newValue in
                    if let textLimit {
                        binding = newValue.count > textLimit ? String(newValue.prefix(textLimit)) : newValue
                    }
                }
            
            if let textLimit {
                HStack {
                    Text("\(binding.count)/\(textLimit)")
                        .font(regular15f)
                        .foregroundColor(.gray600)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal, 5)
            }
        }
    }
}

//#Preview {
//    AccTextField()
//}
