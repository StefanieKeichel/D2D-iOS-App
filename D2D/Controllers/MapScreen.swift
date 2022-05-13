import UIKit
import MapKit
import CoreLocation
import Foundation
import AVFoundation

class MapScreen: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
//    let systemSoundID: SystemSoundID = 1016
    let systemSoundID: SystemSoundID = 1005
    let LocationManager = CLLocationManager()
    let regionInMeters: Double = 1000
    let radius_alert: Double  = 20
    
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
//        load the screen
        super.viewDidLoad()
//        self.locationManager.requestAlwaysAuthorization()
//        check if the location is enabled or not (for the entire device in the settings)
        checkLocationServices()
        setUpGeofenceForCarAccident()
    }
    
    func setUpGeofenceForCarAccident() {
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2D(latitude: 37.334744, longitude: -122.033957), radius: radius_alert, identifier: "CarAccident")
        locationManager.startMonitoring(for: geoFenceRegion)
//        vizualize position on the map
//        let placeRegion = placemark?.region

    }


    func setupLocationManager() {
        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        let logger: (String) -> Void = showAlert
        let didEnterMessage = "broken down vehicle ahead in " + String(Int(radius_alert/2)) + " m"
        logger(didEnterMessage)
        AudioServicesPlaySystemSound(systemSoundID)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [self] in
            let utterance = AVSpeechUtterance(string: didEnterMessage)
            utterance.voice = AVSpeechSynthesisVoice(language: "en-USA")
            utterance.rate = 0.43
            let synthesizer = AVSpeechSynthesizer()
            synthesizer.speak(utterance)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        let logger: (String) -> Void = showAlert
        logger("free ride ahead!")
//        AudioServicesPlaySystemSound(systemSoundID)
    }
    
    
    func showAlert(_ disp_message: String) {
        let alert = UIAlertController(title: "", message: disp_message, preferredStyle: .alert)
        alert.setMessageAlignment(.center)
        alert.setMessage(font: UIFont(name: "NSObject", size: 300), color: UIColor(red: 251, green: 247, blue: 255, alpha: 1.0))
        alert.setBackgroundColor(color: UIColor(red: 0.0, green: 0.31, blue: 0.28, alpha: 1.0))
        let constraintHeight = NSLayoutConstraint(
              item: alert.view!, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil,  attribute:
              NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 100, constant: 90)
        
           alert.view.addConstraint(constraintHeight)
        
        self.present(alert, animated: true, completion: nil)
        Timer.scheduledTimer(withTimeInterval: 4.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    

    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
//            MK MapKit
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }

    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            // set up location manager
            setupLocationManager()
            checkLocationAuthorization()
        } else {
    //        if this function is turned off we need to inform the user that it has to be turned on
            // SHOW ALRERT letting the user know they have to turn this on
        }
    }
    
    func checkLocationAuthorization() {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
//            Do map stuff
            break
        case .denied:
//            show alert instructing them how to turn on permissions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
//            show alert letting them know what's up
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
}

//Delegates in extension
extension MapScreen: CLLocationManagerDelegate {
//    update while the user moves
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard against no location;
//        guard: if this condiition is not meet, nothing below this line will happen;
        guard let location = locations.last else  { return }
//        where is the center of the map
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        how wide is the view? want it to be consistent -therefore regionInMeters-Variable
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
//    authorization changes
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        whenever authorization changes
        if (status == CLAuthorizationStatus.authorizedAlways) {
            self.setUpGeofenceForCarAccident()
        }
        checkLocationAuthorization()
    }
    
}

extension UIAlertController {
    
    //Set background color of UIAlertController
    func setBackgroundColor(color: UIColor) {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = color
        }
    }
    
    //Set title font and title color
//    func setTitlet(font: UIFont?, color: UIColor?) {
//        guard let title = self.title else { return }
//        let attributeString = NSMutableAttributedString(string: title)//1
//        if let titleFont = font {
//            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
//                                          range: NSMakeRange(0, title.utf8.count))
//        }
//
//        if let titleColor = color {
//            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
//                                          range: NSMakeRange(0, title.utf8.count))
//        }
//        self.setValue(attributeString, forKey: "attributedTitle")//4
//    }
    
    func setMessageAlignment(_ alignment : NSTextAlignment) {
            let paragraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
            paragraphStyle.alignment = alignment

            let messageText = NSMutableAttributedString(
                string: self.message ?? "",
                attributes: [
                    NSAttributedString.Key.paragraphStyle: paragraphStyle,
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12),
                    NSAttributedString.Key.foregroundColor: UIColor.gray
                ]
            )

            self.setValue(messageText, forKey: "attributedMessage")
        }
    
    
    //Set message font and message color
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    
    //Set tint color of UIAlertController
    func setTint(color: UIColor) {
        self.view.tintColor = color
    }
}


