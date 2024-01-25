//
//  PlaceDetails.swift
//  korusell
//
//  Created by Sergey Li on 1/8/24.
//

import SwiftUI

struct PlaceDetails: View {
    let place: PlacePoint
    var body: some View {
        Text(place.title ?? "notitle")
    }
}

//#Preview {
//    PlaceDetails(place: dummyPlaces.first!)
//}
