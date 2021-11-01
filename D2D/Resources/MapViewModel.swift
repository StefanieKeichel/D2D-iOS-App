import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 52.49413, longitude: 13.44651)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
}

final class MapViewModel: NSObject, ObservableObject,CLLocationManagerDelegate {
    
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    var locationManager: CLLocationManager?
    
    func checkifLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
//            ! means forcing it
            locationManager!.delegate = self
            locationManager?.activityType = CLActivityType.automotiveNavigation
            locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        } else{
            print("Show an alert letting them know this is off and to go turn it on.")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus {
//            if authorization status is not determined
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental control.")
        case .denied:
            print("You have denied this app location permission. Go into settings to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005))
//                                        span: MapDetails.defaultSpan)
//            break
        @unknown default:
            break
        }
    }
//    this is a delegate method
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
}
