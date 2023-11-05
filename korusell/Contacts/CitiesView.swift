//
//  LocationsView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/08/24.
//

import SwiftUI
import FirebaseFirestoreSwift

struct CitiesView: View {
    @FirestoreQuery(collectionPath: "cities") var cities: [City]
    @Binding var selectedCity: City?
    
    var body: some View {
        ActionSheetView(topPadding: topPadding, fixedHeight: true, bgColor: .app_white) {
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "mappin.circle")
                                .font(regular22f)
                            Text("Мое местоположение")
                        }
                        .foregroundColor(.gray900)
                        .padding(.bottom)
                        Button(action: {
                            selectedCity = nil
                        }) {
                            LabelView(title: "Вся Корея", isSelected: selectedCity == nil)
                        }
                        
                        ForEach(cities, id: \.self.en) { city in
                            Button(action: {
                                selectedCity = city
                            }) {
                                LabelView(title: city.ru, isSelected: city == selectedCity)
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
