import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    // You don't need to modify the default init(nibName:bundle:) method.
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        struct State {
            let name: String
            let long: CLLocationDegrees
            let lat: CLLocationDegrees
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        let states = [
            State(name: "Alaska", long: -152.404419, lat: 61.370716),
            State(name: "Alabama", long: -86.791130, lat: 32.806671),
            // the other 51 states here...
        ]
        // Creates a marker in the center of the map.
        for state in states {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: state.lat, longitude: state.long)
            marker.title = state.name
            marker.snippet = "Put pin here"
            marker.map = mapView
        }
       
    }
}
