import Foundation

class MapInteractor: MapInteractorProtocol {
    
    weak var delegate: MapInteractorDelegate!
    var entity: MapEntityProtocol!
    var presenter: MapPresenterProtocol!
    
    func showMeteor(_ meteor: MeteorData) {
        entity.meteorToBeShown = meteor
        presenter.showMeteorOnMap(meteor)
    }
}
extension MapInteractor {
    func didFinishShowingMeteor() {
        delegate.didFinishShowingMeteor()
    }
}
