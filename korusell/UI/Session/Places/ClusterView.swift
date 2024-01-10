/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A subclass of MKAnnotationView that configures itself for representing a MKClusterAnnotation with only Place member annotations.
*/
import MapKit
import SwiftUI

class ClusterView: MKAnnotationView {
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        displayPriority = .defaultHigh
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10) // Offset center point to animate better with marker annotations
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var annotation: MKAnnotation? {
        willSet {
            if let cluster = newValue as? MKClusterAnnotation {
                let renderer = UIGraphicsImageRenderer(size: CGSize(width: 40, height: 40))
                let count = cluster.memberAnnotations.count
//                let uniCount = cluster.memberAnnotations.filter { member -> Bool in
//                    return (member as! PlacePoint).type == .cafe
//                }.count
                
                
                image = renderer.image { _ in
//                     Fill full circle with tricycle color
                    UIColor(Color.app_white).setFill()
                    UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 40, height: 40)).fill()

                    // Fill pie with unicycle color
                    
//                    let piePath = UIBezierPath()
//                    piePath.addArc(withCenter: CGPoint(x: 20, y: 20), radius: 20,
//                                   startAngle: 0, endAngle: (CGFloat.pi * 2.0 * CGFloat(uniCount)) / CGFloat(count),
//                                   clockwise: true)
//                    piePath.addLine(to: CGPoint(x: 20, y: 20))
//                    piePath.close()
//                    piePath.fill()

                    // Fill inner circle with white color
//                    UIColor.systemYellow.setFill()
//                    UIBezierPath(ovalIn: CGRect(x: 16, y: 16, width: 48, height: 48)).fill()

                    // Finally draw count text vertically and horizontally centered
                    let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                                       NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]
                    let text = "\(count)"
                    let size = text.size(withAttributes: attributes)
                    let rect = CGRect(x: 20 - size.width / 2, y: 20 - size.height / 2, width: size.width, height: size.height)
                    text.draw(in: rect, withAttributes: attributes)
                }
            }
        }
    }

}
