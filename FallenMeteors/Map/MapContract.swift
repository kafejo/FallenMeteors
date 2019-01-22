import UIKit.UIViewController

protocol MapRouterProtocol: MapInteractorDelegate {
    var interactor: MapInteractorProtocol! {get set}
    
    func assembleModule() -> UIViewController
}

protocol MapInteractorDelegate: class {

}

protocol MapInteractorProtocol: MapPresenterDelegate {
    var delegate: MapInteractorDelegate! {get set}
    var presenter: MapPresenterProtocol! {get set}
    var entity: MapEntityProtocol! {get set}
    
}

protocol MapPresenterDelegate: class {

}

protocol MapPresenterProtocol: MapViewDelegate {
    var delegate: MapPresenterDelegate! {get set}
    var view: MapViewProtocol! {get set}
}

protocol MapViewDelegate: class {

}

protocol MapViewProtocol: class {
    var delegate: MapViewDelegate! {get set}

}

protocol MapEntityProtocol: class {

}
