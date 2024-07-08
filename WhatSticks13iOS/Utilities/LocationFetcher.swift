//
//  LocationFetcher.swift
//  WS11iOS_v08
//
//  Created by Nick Rodriguez on 31/01/2024.
//

import Foundation
import CoreLocation


enum LocationFetcherError:Error{
    case failedDecode
    case somethingWentWrong
    var localizedDescription:String{
        switch self{
        case.failedDecode: return "Failed to decode"
        default:return "uhhh Idk?"
        }
    }
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    
    static let shared = LocationFetcher()
    
    private let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D?
    private var locationFetchCompletion: ((Bool) -> Void)?
    var arryHistUserLocation:[[String]]?
    var userLocationManagerAuthStatus: String {
        // This computed property returns the string representation of the authorization status
        didSet {
            print(" SET: userLocationManagerAuthStatus --")
            print("Authorization Status Updated: \(userLocationManagerAuthStatus)")
        }
    }
    private let userDefaults = UserDefaults.standard
    private let updateInterval: TimeInterval = 86_400 // 24 hours in seconds
    
    override init() {
        userLocationManagerAuthStatus = LocationFetcher.string(for: locationManager.authorizationStatus)
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.allowsBackgroundLocationUpdates = true // Enable background location updates
        locationManager.pausesLocationUpdatesAutomatically = false // Prevent automatic pausing

    }
    // Convert CLLocationManager.AuthorizationStatus to a readable string
    private static func string(for status: CLAuthorizationStatus) -> String {
        switch status {
        case .notDetermined: return "Not Determined"
        case .restricted: return "Restricted"
        case .denied: return "Denied"
        case .authorizedAlways: return "Authorized Always"
        case .authorizedWhenInUse: return "Authorized When In Use"
        @unknown default: return "Unknown"
        }
    }
    func requestLocationPermission() {
        locationManager.requestAlwaysAuthorization()
    }
    func startMonitoringLocationChanges() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                self.locationManager.startMonitoringSignificantLocationChanges()
                print("############################")
                print("- START: monitoring location changes")
                print("############################")
            }
        }
    }
    func stopMonitoringLocationChanges() {
        self.locationManager.stopMonitoringSignificantLocationChanges()
        print("-----------------------------------")
        print("- STOPPED: monitoring location changes")
        print("-----------------------------------")
    }
    
    func fetchLocation(completion: @escaping (Bool) -> Void) {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                switch self.locationManager.authorizationStatus {
                case .authorizedAlways, .authorizedWhenInUse:
                    self.locationFetchCompletion = completion // Store the completion handler
                    self.locationManager.requestLocation() // Asynchronously updates location
                    print("locationFetcher.fetchLocation: case .authorizedAlways, .authorizedWhenInUse:")

                default:
                    completion(false)
                }
            } else {
                completion(false)
            }
        }
    }
        
    func appendLocationToUserDefaultArryHistUserLocation(lastLocation: CLLocation) {
        
        let arryUserLocation = ["\(getCurrentUtcDateString())", "\(lastLocation.coordinate.latitude)", "\(lastLocation.coordinate.longitude)"]
        if var userLocationArray = UserDefaults.standard.array(forKey: "user_location") as? [[String]] {
            userLocationArray.append(arryUserLocation)
            UserDefaults.standard.set(userLocationArray, forKey: "user_location")
        } else {
            UserDefaults.standard.set([arryUserLocation], forKey: "user_location")
        }
    }

    func checkUserDefaultUserLocation(){
        if let userLocationArray = UserDefaults.standard.array(forKey: "user_location") as? [[String]] {
            self.arryHistUserLocation = userLocationArray
        }
    }
    

}

// MARK: - CLLocationManagerDelegate
extension LocationFetcher {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("- acccessed locationManager(didUpdateLocations) ")
        guard let lastLocation = locations.last else {
            locationFetchCompletion?(true) // Call completion with true since location is updated
            locationFetchCompletion = nil // Clear the stored completion handler
            return }

        currentLocation = lastLocation.coordinate
        let lastUpdateTimestamp = userDefaults.double(forKey: "lastUpdateTimestamp")
        let now = Date().timeIntervalSince1970
        if now - lastUpdateTimestamp >= updateInterval {
//            appendLocationToFile(lastLocation: lastLocation)
            appendLocationToUserDefaultArryHistUserLocation(lastLocation: lastLocation)
            // Update the timestamp of the last processed update
            userDefaults.set(now, forKey: "lastUpdateTimestamp")
        } 
        else{
            locationFetchCompletion?(true) // Call completion with true since location is updated
            locationFetchCompletion = nil // Clear the stored completion handler
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        // Update userLocationManagerAuthStatus when authorization status changes
        userLocationManagerAuthStatus = LocationFetcher.string(for: status)
        
    }
}


//class HistUserLocation:Codable{
//    var dateTimeUtc:String?
//    var latitude:String?
//    var longitude:String?
//}

class DictSendUserLocation:Codable{
    var user_location:[[String]]!
    var timestamp_utc:String!//"yyyyMMdd-HHmm"
}

//class DictUpdate:Codable{
//    var latitude:String!
//    var longitude:String!
//    var location_permission:String!
//    var location_reoccuring_permission:String!
//}
