//
//  MapView.swift
//  MapForKoru2
//
//  Created by Sergey Lee on 2023/07/11.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var places: [PlacePoint]
    @Binding var selectedPlace: PlacePoint?
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        if selectedPlace == nil {
            uiView.deselectAnnotation(selectedPlace, animated: true)
        }
    }
    
    // MARK: Should use later
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:  37.30501026564322, longitude: 126.84550345674847),
                                                   span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03)
    )
    
    class Coordinator: NSObject, MKMapViewDelegate {
        
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
//          if let annotation = view.annotation as? Place {
//              // MARK: Tap logic here
//            print("selected Place is : \(annotation)")
//              parent.selectedPlace = annotation
//          }
        }
        
        
        
        func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
//            withAnimation {
//                parent.selectedPlace = nil
//            }
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? PlacePoint {
                // MARK: Tap logic here
              print("selected Place is : \(annotation)")
                withAnimation {
                    parent.selectedPlace = annotation
                }
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        MapView.Coordinator(self)
    }
    
    
    func makeUIView(context: Context) -> MKMapView {
        ///  creating a map
        let view = MKMapView()
        /// connecting delegate with the map
        view.delegate = context.coordinator
        view.setRegion(region, animated: false)
        view.mapType = .standard
        view.register(PlaceMarker.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        view.register(ClusterView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
        
        view.addAnnotations(places)

        return view
    }
}

