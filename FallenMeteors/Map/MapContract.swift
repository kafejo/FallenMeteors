import UIKit.UIViewController

protocol MapRouterProtocol: MapInteractorDelegate {
    var interactor: MapInteractorProtocol! {get set}
    
    func assembleModule() -> UIViewController
}

protocol MapInteractorDelegate: class {
    func didFinishShowingMeteor()
}

protocol MapInteractorProtocol: MapPresenterDelegate {
    var delegate: MapInteractorDelegate! {get set}
    var presenter: MapPresenterProtocol! {get set}
    var entity: MapEntityProtocol! {get set}
    
    func showMeteor(_ meteor: MeteorData)
}

protocol MapPresenterDelegate: class {
    func didFinishShowingMeteor()
}

protocol MapPresenterProtocol: MapViewDelegate {
    var delegate: MapPresenterDelegate! {get set}
    var view: MapViewProtocol! {get set}
    
    func showMeteorOnMap(_ meteor: MeteorData)
}

protocol MapViewDelegate: class {
    func didFinishShowingMeteor()
}

protocol MapViewProtocol: class {
    var delegate: MapViewDelegate! {get set}
    
    func showMeteorOnMap(_ meteor: MeteorData)
}

protocol MapEntityProtocol: class {
    var meteorToBeShow: MeteorData! {get set}
}
