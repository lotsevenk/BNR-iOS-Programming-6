//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by AmeriHealth Caritas Employee on 10/4/17.
//  Copyright © 2017 Tin Pan Tech. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation 
struct pinInfo {
    var location: CLLocation
    var description: String
}
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate	 {
    var locationManager: CLLocationManager!
    var mapView: MKMapView!
    var annotationList: [MKPointAnnotation]!
        
    var pinIndex: Int = 0
    override func loadView() {
        // Create a map view
        let p1 = MKPointAnnotation()
        p1.coordinate = CLLocationCoordinate2D(latitude:39.866564, longitude: -75.388854)
        p1.title =  "Brookhaven"
        let p2 = MKPointAnnotation()
        p2.coordinate = CLLocationCoordinate2D(latitude:40.613177, longitude: -74.290972)
        p2.title = "Rahway Hospital"
        let p3 = MKPointAnnotation()
        p3.coordinate = CLLocationCoordinate2D(latitude:43.879102, longitude: -103.459067)
        p3.title = "Mount Rushmore"
        annotationList = [p1,p2,p3]
        
        mapView = MKMapView()
        mapView.delegate = self
        //mapView.isZoomEnabled = true
        //mapView.isScrollEnabled = true
        
        // Set it as "the" view of this view controller
        view = mapView
        
        let randomLocationButton = UIButton()
        randomLocationButton.setTitle("Random Location", for: .normal)
        randomLocationButton.addTarget(self,
                                       action: #selector(getRandomLocation(_:)),
                                       for: .touchUpInside)
        randomLocationButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        randomLocationButton.setTitleColor(UIColor.black, for: .normal)
        randomLocationButton.translatesAutoresizingMaskIntoConstraints = false
//        randomLocationButton.layer.borderWidth = 0.5
//        randomLocationButton.layer.borderColor = UIColor.black.cgColor
        view.addSubview(randomLocationButton)
        let topRandomLocationButtonConstraint = randomLocationButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 16)
        let leadingRandomLocationButtonConstraint = randomLocationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingRandomLocationButtonConstraint = randomLocationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)

        topRandomLocationButtonConstraint.isActive = true
        leadingRandomLocationButtonConstraint.isActive = true
        trailingRandomLocationButtonConstraint.isActive = true

        
    }
    
    @objc func getRandomLocation(_ sender: UIButton) {
        let region =  MKCoordinateRegionMakeWithDistance(annotationList[pinIndex].coordinate, 700, 700)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(annotationList[pinIndex])
        pinIndex += 1
        pinIndex = pinIndex % 3
    }
    
    func mapView(_ mapView:MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: "") as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotationList[pinIndex], reuseIdentifier: "")
            pinView!.canShowCallout = true
            pinView!.animatesDrop = true
            pinView!.pinTintColor = MKPinAnnotationView.purplePinColor()
        } else {
            pinView?.annotation = annotationList[pinIndex]
        }
        return pinView
    }
}
