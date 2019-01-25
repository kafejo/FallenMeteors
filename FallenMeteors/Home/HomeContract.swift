import Foundation
import UIKit

protocol HomeRouterProtocol: HomeInteractorDelegate {
    var interactor: HomeInteractorProtocol! {get set}
    
    func assembleModule() -> UIViewController
}

protocol HomeInteractorDelegate: class {
    
}

protocol HomeInteractorProtocol: HomePresenterDelegate {
    var delegate: HomeInteractorDelegate! {get set}
    var entity: HomeEntityProtocol! {get set}
    var presenter: HomePresenterProtocol! {get set}
    
    func loadData()
    func showMeteors()
}

protocol HomePresenterDelegate: class {
    func UIDidLoad()
}

protocol HomePresenterProtocol: HomeViewDelegate {
    var delegate: HomePresenterDelegate! {get set}
    var view: HomeViewProtocol! {get set}
    
    func showMeteorData(_ meteorData: [MeteorData])

}

protocol HomeViewDelegate: class {
    func viewDidLoad()
}

protocol HomeViewProtocol: UITableViewDelegate, UITableViewDataSource {
    var delegate: HomeViewDelegate! {get set}
    
    func showMeteorData(_ meteorData: [MeteorData])
}

protocol HomeEntityProtocol: Codable {
    var url: URL! {get set}
    var meteorsOrderedBySize: [MeteorData]! {get set}
    
    func archive()
    static func retrieveArchive() -> HomeEntityProtocol
}
