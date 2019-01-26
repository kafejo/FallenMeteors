import UIKit.UIViewController
import MapKit

class MapView: UIViewController, MapViewProtocol {
    
    weak var delegate: MapViewDelegate!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBAction func backButton(_ sender: Any) {
        delegate.didFinishShowingMeteor()
    }
    
    func showMeteorOnMap(_ meteor: MeteorData) {
        let meteorMarker = MKPointAnnotation()

        guard let latitude = meteor.geoLocation?.latitude, let longitude = meteor.geoLocation?.longitude else { return }
        let meteorLocation = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        meteorMarker.coordinate = meteorLocation
        mapView.addAnnotation(meteorMarker)
        panTo(location: meteorLocation)
    }
    
    private func panTo(location: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25.0, longitudeDelta: 25.0))
        mapView.setRegion(region, animated: true)
    }
}
