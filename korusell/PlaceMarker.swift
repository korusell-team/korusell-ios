/*
A subclass of MKMarkerAnnotationView that configures itself for representing a Place.
*/
import MapKit
import UIKit
import SwiftUI


/// need to customize markers images
class PlaceMarker: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            if let place = newValue as? PlacePoint {
                clusteringIdentifier = "place"
              
                // MARK: Markers as balloons with custom icons
                glyphImage = UIImage(named: "cafe")
//                if place.type == .cafe {
//                    markerTintColor = UIColor(Color.red200)
//                    glyphImage = UIImage(named: "cafe")
//                    displayPriority = .defaultLow
//                } else {
//                    markerTintColor = UIColor(Color.blue200)
//                    glyphImage = UIImage(named: "shop")
//                    displayPriority = .defaultHigh
//                }
                
                
//                canShowCallout = true
//                rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               
                
                // MARK: fully custom markers:
//                let pinImage = UIImage(named: "pin")
//                        let size = CGSize(width: 50, height: 50)
//                        UIGraphicsBeginImageContext(size)
//                        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//                        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//                frame.size = CGSize(width: 40, height: 40)
//
//                image = pinImage
//                markerTintColor = .clear
//                glyphImage = UIImage(named: "")
            }
        }
    }

}
