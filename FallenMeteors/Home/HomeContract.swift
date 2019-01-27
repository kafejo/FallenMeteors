import Foundation
import UIKit

protocol HomeRouterProtocol: HomeInteractorDelegate {
    var interactor: HomeInteractorProtocol! {get set}
    
    func assembleModule() -> UIViewController
}

protocol HomeInteractorDelegate: class {
    func didSelectMeteor(meteor: MeteorData)
}

protocol HomeInteractorProtocol: HomePresenterDelegate {
    var delegate: HomeInteractorDelegate! {get set}
    var entity: HomeEntityProtocol! {get set}
    var presenter: HomePresenterProtocol! {get set}
    
    func beginBackendSyncHeartbeat()
    func showMeteors()
    func loadData()
}

protocol HomePresenterDelegate: class {
    func UIDidLoad()
    func didSelectMeteor(meteor: MeteorData)
}

protocol HomePresenterProtocol: HomeViewDelegate {
    var delegate: HomePresenterDelegate! {get set}
    var view: HomeViewProtocol! {get set}
    
    func showMeteorData(meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData])

}

protocol HomeViewDelegate: class {
    func viewDidLoad()
    func didSelectMeteor(meteor: MeteorData)
}

protocol HomeViewProtocol: UITableViewDelegate, UITableViewDataSource {
    var delegate: HomeViewDelegate! {get set}
    
    func showMeteorData(meteorsOrderedByMass: [MeteorData], meteorsWithoutMass: [MeteorData])
    func presentViewController(_ viewController: UIViewController)
    func dismissCurrentChildVC()
}

protocol HomeEntityProtocol: Codable {
    var lastBackendSync: Date! {get set}
    
    var meteorsOrderedByMass: [MeteorData]? {get set}
    var meteorsWithoutMass: [MeteorData]? {get set}
    
    func archive()
    static func retrieveArchive() -> HomeEntityProtocol
}
