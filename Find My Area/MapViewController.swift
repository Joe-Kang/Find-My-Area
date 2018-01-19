import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UITextFieldDelegate {
    var pointsLocations = GMSMutablePath()
    var clickedLocations = [CLLocation?]()
    var currentLocation: CLLocation?
    let locationManager = CLLocationManager()
    
    weak var delegate:MapViewControllerDelegate?
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if pointsLocations.count() == 2{
            let distance = GMSGeometryDistance(pointsLocations.coordinate(at: 0), pointsLocations.coordinate(at: 1))
            delegate?.returnDistance(by: self, distance )
        }
        else if pointsLocations.count() > 2{
            delegate?.returnDistance(by: self, GMSGeometryArea(pointsLocations))
        }
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        enableBasicLocationServices()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextField.resignFirstResponder()
        return true
    }

    func enableBasicLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            enableMyWhenInUseFeatures()
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted, .denied:
            disableMyLocationBasedFeatures()
            break
            
        case .authorizedWhenInUse:
            enableMyWhenInUseFeatures()
            break
            
        case .notDetermined, .authorizedAlways:
            break
        }
    }
    
    func disableMyLocationBasedFeatures(){
        print("disableMyLocationBasedFeatures")
    }
    
    func enableMyWhenInUseFeatures(){
        print("enableMyWhenInUseFeatures")
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 0.5  // In meters.
        locationManager.startUpdatingLocation()
    }

    
    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last!
        let camera = GMSCameraPosition.camera(withLatitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!, zoom: 20.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!))
        mapView.delegate = self
        self.view = mapView
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        marker.map = mapView
        
        for location in clickedLocations {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!)
            marker.map = mapView
        }
        let path = GMSMutablePath()
        for location in clickedLocations {
            path.add(CLLocationCoordinate2D(latitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!))
        }
        if clickedLocations.count > 2 {
            let polygon = GMSPolygon(path: path)
            polygon.fillColor = UIColor(red: 0.25, green: 0, blue: 0, alpha: 0.2)
            polygon.strokeColor = .black
            polygon.strokeWidth = 2
            polygon.map = mapView
        } else if clickedLocations.count == 2 {
            let line = GMSPolyline(path: path)
            line.strokeColor = .black
            line.strokeWidth = 2
            line.map = mapView
        }
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: (currentLocation?.coordinate.latitude)!, longitude: (currentLocation?.coordinate.longitude)!)
        pointsLocations.add((currentLocation?.coordinate)!)
        clickedLocations.append(currentLocation)
        marker.map = mapView
    }
}
