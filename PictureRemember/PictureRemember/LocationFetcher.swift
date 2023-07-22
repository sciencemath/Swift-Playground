//
//  LocationFetcher.swift
//  PictureRemember
//
//  Created by Mathias on 7/21/23.
// @TODO there might be better way to do this with iOS16+
// NOTE: had to add "Privacy - Location When In Use Usage Description" to the info bundle

import Foundation
import CoreLocation

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var lastKnownLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func start() {
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate
    }
}
