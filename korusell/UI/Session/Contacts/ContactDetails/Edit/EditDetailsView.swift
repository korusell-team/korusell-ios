//
//  EditDetailsView.swift
//  korusell
//
//  Created by Sergey Li on 12/29/23.
//

import SwiftUI

struct EditDetailsView: View {
    @Binding var user: Contact
    @Binding var image: UIImage?
    @Binding var showAlert: Bool
    
    @State var showImagePicker = false
    
    let animation: Namespace.ID
    
    var body: some View {
        ScrollView {
            LazyVStack {
                EditContactImageView(user: $user, image: $image, showImagePicker: $showImagePicker, animation: animation)
                    .alertPatched(isPresented: $showAlert) {
                        Alert(title: Text("Чтобы сделать аккаунт публичным"), message:
                                Text("\n• Укажите имя\n• Загрузите фото\n• Заполните Био\n• Выберите категорию")
                        )
                    }
                
                EditContactView(user: $user)
                    .background(Color.gray10.opacity(0.1))
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            }
        }
    }
}

//#Preview {
//    EditDetailsView()
//}
