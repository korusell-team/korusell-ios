//
//  CitySelectionView.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/20.
//

import SwiftUI
import FirebaseFirestoreSwift

struct CitySelectionView: View {
    @EnvironmentObject var userManager: UserManager
    @FirestoreQuery(collectionPath: "cities", predicates: []) var cities: [City]
    @Binding var isOpened: Bool
    
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
                        userManager.user?.cities = ["Вся Корея"]
                    }) {
                        LabelView(title: "Вся Корея", isSelected: userManager.user?.cities.contains("Вся Корея") ?? false)
                    }
                    
                    ForEach(cities, id: \.self.en) { city in
                        Button(action: {
                            userManager.user?.cities = [city.ru]
                        }) {
                            LabelView(title: city.ru, isSelected: userManager.user?.cities.contains(city.ru) ?? false)
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


struct CitySelectionView_Previews: PreviewProvider {
    static var previews: some View {
        CitySelectionView(isOpened: .constant(true))
    }
}
