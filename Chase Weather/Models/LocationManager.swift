//
//  LocationManager.swift
//  Chase Weather
//
//  Created by John Kang on 5/16/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var post: ((CLLocation) -> ())?
    var handleNoPermission: (() -> ())?
        
    func getLocation(_ post: @escaping (CLLocation) -> (), handleNoPermission: @escaping () -> ()) {
        self.post = post
        self.handleNoPermission = handleNoPermission
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse {
            self.post!(manager.location!)
        } else {
            self.handleNoPermission!()
        }
    }
}
