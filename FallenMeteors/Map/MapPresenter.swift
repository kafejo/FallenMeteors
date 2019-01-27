import Foundation
import MapKit

class MapPresenter: MapPresenterProtocol {

    weak var delegate: MapPresenterDelegate!
    var view: MapViewProtocol!
    
    func showMeteorOnMap(_ meteor: MeteorData) {
        
        let meteorMarker = MKPointAnnotation()
        
        guard let latitude = meteor.geoLocation?.latitude, let longitude = meteor.geoLocation?.longitude else { return }
        
        let meteorLocationAsWSG84 = CLLocation(latitude: latitude, longitude: longitude)
        let meteor2DLocation = CLLocationCoordinate2DMake(meteorLocationAsWSG84.coordinate.latitude, meteorLocationAsWSG84.coordinate.longitude)
        
        meteorMarker.coordinate = meteor2DLocation
        
        view.showMeteorOnMap(meteor, meteorMarker: meteorMarker)
        panTo(location: meteor2DLocation)
    }
    
    private func panTo(location: CLLocationCoordinate2D) {
        
        let region = MKCoordinateRegion(center: location, span: MKCoordinateSpan(latitudeDelta: 25.0, longitudeDelta: 25.0))
        view.panTo(region: region)
    }
}
extension MapPresenter {
    func didFinishShowingMeteor() {
        delegate.didFinishShowingMeteor()
    }
}
