//
//  LocationsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/24.
//

import SwiftUI

struct LocationsView: View {
    @State var selectedCity: City? = nil
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "mappin.circle")
                    .font(title2Font)
                Text("Мое местоположение")
            }
            .foregroundColor(.gray900)
            
            Button(action: {
                self.selectedCity = nil
            }) {
                LabelView(title: "Вся Корея", isSelected: selectedCity == nil)
            }
            
            ForEach(cities) { city in
                Button(action: {
                    self.selectedCity = city
                }) {
                    LabelView(title: city.title, isSelected: city == selectedCity)
                }
            }
        }
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
    }
}
