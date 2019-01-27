import UIKit.UIViewController
import MapKit

class MapView: UIViewController, MapViewProtocol {
    
    weak var delegate: MapViewDelegate!
    
    @IBOutlet var mapView: MKMapView!
    @IBOutlet var meteoriteNameLabel: UILabel!
    @IBOutlet var meteoriteDescriptionLabel: UILabel!
    
    @IBAction func backButton(_ sender: Any) {
        delegate.didFinishShowingMeteor()
    }
    
    func showMeteorDetails(meteorName: String, meteorDescription: String, meteorMarker: MKPointAnnotation) {
        meteoriteNameLabel.text = meteorName
        meteoriteDescriptionLabel.text = meteorDescription
        mapView.addAnnotation(meteorMarker)
    }
    
    func panTo(region: MKCoordinateRegion) {
        mapView.setRegion(region, animated: false)
    }
}
