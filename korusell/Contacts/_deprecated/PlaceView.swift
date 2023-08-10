//
//  PlaceView.swift
//  korusell
//
//  Created by Sergey Lee on 2023/06/04.
//

import SwiftUI

struct PlaceView: View {
    let place: Place
    var body: some View {
        VStack {
            Text(place.name)
        }
    }
}

struct PlaceView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                PlaceView(place: Place(name: "Кафе Виктория", subcategories: ["мероприятия", "праздники", "свадьбы", "асянди", "хангаби"], owner: "asd"))
                PlaceView(place: Place(name: "Habsida", subcategories: ["IT", "программирование", "обучение"], owner: "asd"))
                PlaceView(place: Place(name: "СТО", subcategories: ["транспорт", "ремонт"], owner: "asd"))
            }
        }
        .background(Color.bg)
        .environmentObject(ContactsController())
    }
}

