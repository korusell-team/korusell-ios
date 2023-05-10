//
//  MemberView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/05/10.
//

import SwiftUI

struct MemberView: View {
    let member: Member
    
    var body: some View {
        VStack {
            Color.white
                .frame(width: 100, height: 100)
                .clipShape(Circle())
                .padding()
                .padding(.top)
            HStack {
                Text(member.surname)
                Text(member.name)
            }
             .foregroundColor(.yellow)
             .font(.body)
             .padding(.bottom, 5)
            
            Text("@" + member.nickname)
                .foregroundColor(.gray)
                .padding(.bottom)
        }
            
            
            .frame(maxWidth: .infinity)
            .background(Color.teal)
            .cornerRadius(10)
            
    }
}

struct MemberView_Previews: PreviewProvider {
    static var previews: some View {
        ContactsScreen()
    }
}
