/*
A subclass of MKMarkerAnnotationView that configures itself for representing a Place.
*/
import MapKit
import UIKit
import SwiftUI


class PlaceMarker: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            if let place = newValue as? PlacePoint {
                
                clusteringIdentifier = "place"
                // MARK: Markers as balloons with custom icons
//                glyphImage = UIImage(named: "cafe")
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
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                image = renderer.image { _ in
//                     Fill full circle with tricycle color
                    UIColor(Color.white).setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()
                    UIColor(Color.gray300).setStroke()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 39, height: 39)).stroke()
                    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
                    
                    var cats: [Category] = []
                    var text = "👾"
                    if let data = UserDefaults.standard.data(forKey: "cats") {
                        if let decoded = try? JSONDecoder().decode([Category].self, from: data) {
                            cats = decoded
                            text = cats.first(where: { $0.id == place.categories.first})?.emoji ?? "👾"
                 
                        }
                    }
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
                
                
                // MARK: fully custom markers:
//                let pinImage = UIImage(named: "pin-bg")
//                        let size = CGSize(width: 50, height: 50)
//                        UIGraphicsBeginImageContext(size)
//                        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
//                        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
//                frame.size = CGSize(width: 40, height: 40)
//                image = resizedImage
                
                // MARK: hides original pin
                markerTintColor = .clear
                glyphImage = nil
                self.glyphTintColor = UIColor.clear
                self.markerTintColor = UIColor.clear
            }
        }
    }

}
