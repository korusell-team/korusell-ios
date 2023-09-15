//
//  LocationsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/24.
//

import SwiftUI

struct CitiesView: View {
    @EnvironmentObject var cc: ContactsController
    
    var body: some View {
        ActionSheetView(topPadding: topPadding, fixedHeight: true, bgColor: .white) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "mappin.circle")
                                .font(title2Font)
                            Text("Мое местоположение")
                        }
                        .foregroundColor(.gray900)
                        .padding(.bottom)
                        Button(action: {
                            cc.city = nil
                        }) {
                            LabelView(title: "Вся Корея", isSelected: cc.city == nil)
                        }
                        
                        ForEach(cc.cities, id: \.self.en) { city in
                            Button(action: {
                                cc.city = city.ru
                            }) {
                                LabelView(title: city.ru, isSelected: city.ru == cc.city)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 25)
            }
    }
    
    private var topPadding: CGFloat {
        switch Size.type {
        case .button: return 168
        case .island: return 200
        case .notch: return 190
        case .mini: return 190
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
//        LocationsView()
        ContactsScreen()
            .environmentObject(ContactsController())
    }
}
