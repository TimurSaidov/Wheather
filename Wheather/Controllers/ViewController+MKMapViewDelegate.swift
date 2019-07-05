//
//  ViewController+MKMapViewDelegate.swift
//  Wheather
//
//  Created by Timur Saidov on 04/07/2019.
//  Copyright © 2019 Timur Saidov. All rights reserved.
//

import Foundation
import MapKit

extension ViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotationID") as? MKPinAnnotationView
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "annotationID")
            annotationView?.canShowCallout = true
        }
        return annotationView
    }
}
