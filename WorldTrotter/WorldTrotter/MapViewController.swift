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
    let locationsOfInterest = [pinInfo(location: CLLocation(latitude:39.866564, longitude: -75.388854),description:  "Brookhaven"),
                               pinInfo(location: CLLocation(latitude:40.613177, longitude: -74.290972), description: "Rahway Hospital"),
                               pinInfo(location: CLLocation(latitude:43.879102, longitude: -103.459067),description: "Mount Rushmore")]
    var currentLOI = 0
    override func loadView() {
        // Create a map view
        mapView = MKMapView()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        
        // Set it as "the" view of this view controller
        view = mapView
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        
        segmentedControl.addTarget(self, action: #selector(MapViewController.mapTypeChanged(_:)), for: .valueChanged)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        let topConstraint = segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8)
        
        let margins = view.layoutMarginsGuide
        let leadingConstraint = segmentedControl.leadingAnchor.constraint(equalTo:margins.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
        let currentLocationButton = UIButton(type: UIButtonType.system) as UIButton
        currentLocationButton.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
        currentLocationButton.setTitle("Show Next Location", for: UIControlState.normal)
        currentLocationButton.layer.borderWidth = 0.5
        currentLocationButton.layer.borderColor = UIColor.black.cgColor
        currentLocationButton.addTarget(self, action: #selector(MapViewController.showLocation(_:)), for: .touchUpInside)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(currentLocationButton)
        let clTopConstraint = currentLocationButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 8)
        let clCenter = currentLocationButton.centerXAnchor.constraint(equalTo: margins.centerXAnchor)
        clTopConstraint.isActive = true
        clCenter.isActive = true

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    @objc func showLocation(_ buttonCS: UIControlState) {
        currentLOI += 1
        if currentLOI > locationsOfInterest.count - 1 {
            currentLOI = 0
        }
        showCurrentLOI(currentLOI)
    }
    func determineCurrentLocation()
    {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            //locationManager.startUpdatingHeading()
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation:CLLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        //manager.stopUpdatingLocation()
        
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapView.setRegion(region, animated: true)
        
        // Drop a pin at user's Current Location
        let myAnnotation: MKPointAnnotation = MKPointAnnotation()
        myAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);
        myAnnotation.title = "Current location"
        mapView.addAnnotation(myAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }

}
