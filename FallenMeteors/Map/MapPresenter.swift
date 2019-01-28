import MapKit

class MapPresenter: MapPresenterProtocol {

    weak var delegate: MapPresenterDelegate!
    var view: MapViewProtocol!
    
    func showMeteorOnMap(_ meteor: MeteorData) {

        guard let latitude = meteor.geoLocation?.latitude, let longitude = meteor.geoLocation?.longitude else { return }

        let meteorLocation = CLLocation(latitude: latitude, longitude: longitude)
    
        let meteorMarker = MKPointAnnotation()
        meteorMarker.coordinate = meteorLocation.coordinate

        let meteorName = formateMeteorName(meteor.name)
        var meteorDescription = formatMeteorDescription(name: meteorName, meteor: meteor)
        
        getLocationNameFromCoords(meteorLocation) { [weak self] (locationName) in
            
            if let locationName = locationName {
                meteorDescription += " in \(locationName)"
            }
            
            self?.view.showMeteorDetails(meteorName: meteorName, meteorDescription: meteorDescription, meteorMarker: meteorMarker)
            self?.panTo(location: meteorLocation.coordinate)
        }
     
    }
    
    private func formateMeteorName(_ name: String?) -> String {
        
        let meteorName: String
        if let name = name {
            meteorName = name
        }
        else {
            meteorName = "This unknown meteor"
        }
        
        return meteorName
    }
    
    private func formatMeteorDescription(name:String, meteor: MeteorData) -> String {
        
        let mass: String
        if let meteorMass = meteor.mass {
            mass = ("a mass of " + meteorMass)
        }
        else {
            mass = "an unknown mass"
        }
        
        let fellAtDate: String
        if let date = meteor.fellAtDate {
            fellAtDate = date
        }
        else {
            fellAtDate = "an unknown date"
        }
        
        // Showing raw date from the API instead of using DateFormatter
        return "\(name) has \(mass) and fell on \(fellAtDate)"
    }
    
    private func getLocationNameFromCoords(_ location: CLLocation, completionHandler: @escaping (String?) -> Void) {
    
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { result, error -> Void in
            
            //Not neccessary, just an extra if the user is connected to the internet
            if error != nil { completionHandler(nil); return }

            guard let locationInfo = result?.first else { return }

            var locationName: String? = nil
            if let country = locationInfo.country {
                locationName = country
            }
            
            completionHandler(locationName)
            
        })
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
