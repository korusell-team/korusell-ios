//
//  PlacePoint.swift
//  korusell
//
//  Created by Sergey Li on 2023/09/06.
//

import Foundation
import MapKit

class PlacePoint: NSObject, MKAnnotation, Identifiable {
    enum placeType: String {
        case cafe, shop
    }
    
    let type: placeType
    var address: String?
    let coordinate: CLLocationCoordinate2D
    var title: String?
    var bio: String?
    
    init(
        type: placeType,
        address: String? = nil,
        coordinate: CLLocationCoordinate2D,
        title: String? = nil,
        bio: String? = nil
    ) {
        self.type = type
        self.address = address
        self.coordinate = coordinate
        self.title = title
        self.bio = bio
        super.init()
    }
}
