//
//  GlobalSearchView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/23.
//

import SwiftUI
import FirebaseAuth

struct GlobalSearchView: View {
    @AppStorage("log_Status") var status = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            Text("🚧 здесь нужен дизайн...")
            Button(action: {
                do {
                    try Auth.auth().signOut()
                    userManager.user = nil
                } catch {
                    
                }
                
                withAnimation { status = false }
            }) {
                Text("Выйти")
            }
        }
    }
}

struct GlobalSearchView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalSearchView()
    }
}
