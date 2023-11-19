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
    @EnvironmentObject var cc: ContactsController
    @Binding var isOpened: Bool
    
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
                        userManager.user?.cities = [0]
                    }) {
                        LabelView(title: "Вся Корея", isSelected: userManager.user?.cities.contains(0) ?? false)
                    }
                    
                    ForEach(cc.cities, id: \.self.id) { city in
                        Button(action: {
                            userManager.user?.cities = [city.id]
                        }) {
                            LabelView(title: city.ru, isSelected: userManager.user?.cities.contains(city.id) ?? false)
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
