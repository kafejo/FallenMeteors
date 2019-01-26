import Foundation


class MapPresenter: MapPresenterProtocol {

    weak var delegate: MapPresenterDelegate!
    var view: MapViewProtocol!
    
    func showMeteorOnMap(_ meteor: MeteorData) {
        view.showMeteorOnMap(meteor)
    }
}
extension MapPresenter {
    func didFinishShowingMeteor() {
        delegate.didFinishShowingMeteor()
    }
}
