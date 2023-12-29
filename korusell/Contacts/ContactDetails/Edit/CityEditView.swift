//
//  CityEditView.swift
//  korusell
//
//  Created by Sergey Li on 12/29/23.
//

import SwiftUI

struct CityEditView: View {
    @Binding var user: Contact
    @State var citiesPresented = false
    let cities: [City]
    
    var body: some View {
        Button(action: {
            citiesPresented = true
        }) {
            HStack(alignment: .center) {
                Text("Город")
                    .frame(width: Size.w(90), alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                    ForEach(user.cities, id: \.self) { id in
                        if let city = cities.first(where: { $0.id == id }) {
                            Text(city.ru)
                                .font(regular17f)
                                .foregroundColor(.gray800)
                                .padding(.trailing, 6)
                                .onTapGesture {
                                    citiesPresented = true
                                }
                        }
                    }
                }
                }
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray800)
            }
            .foregroundColor(.gray1100)
            .background(Color.white.opacity(0.1))
            .popup(isPresented: $citiesPresented) {
                EditPopCitiesView(user: $user, popCities: $citiesPresented)
            } customize: {
                $0
                    .type (.floater())
                    .position(.top)
                    .dragToDismiss(true)
                    .closeOnTapOutside(true)
                    .backgroundColor(.black.opacity(0.2))
            }
        }
    }
}

//#Preview {
//    CityEditView()
//}
