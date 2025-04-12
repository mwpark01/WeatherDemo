//
//  CurrentLocationManager.swift
//  WeatherDemo
//
//  Created by mwpark on 4/12/25.
//

import Foundation
import CoreLocation

// 현재 위치를 가져온다.
class CurrentLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let manager = CLLocationManager()
    
    @Published var location: CLLocation?
    
    // 현재 위치 권한을 물어본다.
    override init() {
        super.init()
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first
        manager.stopUpdatingLocation()
    }
}
