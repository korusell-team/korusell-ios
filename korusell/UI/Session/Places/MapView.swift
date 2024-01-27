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
        // TODO: figure out better way to update annotations
        if places.map({ $0.title?.description ?? "" }) != uiView.annotations.map({ $0.title ?? "" }) {
            print(places.map({ $0.title }))
            print(uiView.annotations.map({ $0.title }))
            
            print("refreshing ....")
            DispatchQueue.main.async {
//                withAnimation {
                    uiView.removeAnnotations(uiView.annotations)
//                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
//                withAnimation {
                    uiView.addAnnotations(places)
//                }
            }
        }
        
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
            print(view.annotation)
                withAnimation {
                    /// doesnt work resizing
//                    view.annotation. = CGRect(x: 0, y: 0, width: 40, height: 40)
                }
            
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            if let annotation = view.annotation as? PlacePoint {
                // MARK: Tap logic here
                print("selected Place is : \(annotation.pid)")
                withAnimation {
                    parent.selectedPlace = annotation
                    /// doesnt work resizing
//                    view.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
                }
                parent.region = MKCoordinateRegion(center: annotation.coordinate,
                                                          span: MKCoordinateSpan(latitudeDelta: 0.03, longitudeDelta: 0.03))
                mapView.setRegion(parent.region, animated: true)

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

