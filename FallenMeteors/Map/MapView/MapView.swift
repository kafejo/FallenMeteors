import UIKit.UIViewController
import MapKit

class MapView: UIViewController, MapViewProtocol {
    
    weak var delegate: MapViewDelegate!
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var meteoriteName: UILabel!
    @IBOutlet var meteoriteDescription: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        delegate.didFinishShowingMeteor()
    }
    
    func showMeteorOnMap(_ meteor: MeteorData, meteorMarker: MKPointAnnotation) {
        mapView.addAnnotation(meteorMarker)
    }
    
    func panTo(region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: false)
    }
}
