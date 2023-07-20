//
//  PlacesScreen.swift
//  korusell
//
//  Created by Sergey Lee on 2023/07/20.
//

import SwiftUI

struct PlacesScreen: View {
    @State var selectedPlace: PlacePoint? = nil
    
    var body: some View {
        ZStack(alignment: .bottom) {
            MapView(selectedPlace: $selectedPlace)
        }
        .ignoresSafeArea()
        .sheet(item: $selectedPlace) { place in
            VStack {
                Text(place.title ?? "")
            }
            .onDisappear {
                print("Disappear")
                selectedPlace = nil
            }
        }
    }
}

struct PlacesScreen_Previews: PreviewProvider {
    static var previews: some View {
        PlacesScreen()
    }
}
